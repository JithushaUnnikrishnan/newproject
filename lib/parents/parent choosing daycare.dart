
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'VIEW.dart';

class ChoosingDaycare extends StatefulWidget {
  const ChoosingDaycare({
    super.key,
    required this.phone,
    required this.childname,
    this.parentname,
    this.dob,
    this.Email,
    this.pass,
    this.address,
  });
  final phone;
  final childname;
  final parentname;
  final dob;

  final Email;
  final pass;
  final address;

  @override
  State<ChoosingDaycare> createState() => _ChoosingDaycareState();
}

class _ChoosingDaycareState extends State<ChoosingDaycare> {
  var ID;
  String? selectedDaycareId; // Variable to store selected daycare ID
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  names() {
    print(widget.phone);
    print(widget.parentname);
    print(widget.childname);
    print(widget.address);
    print(widget.Email);
    print(widget.dob);
  }

  final date = new DateTime.now();
  Future<dynamic> ParentReg() async {
    await FirebaseFirestore.instance.collection("ParentRegister").add({
      "Parent Name": widget.parentname,
      "Phone": widget.phone,
      "Email": widget.Email,
      "Password": widget.pass,
      "Daycare_id": selectedDaycareId,
      "Child name": widget.childname,
      "Date of birth": widget.dob,
      "Address": widget.address,
      "gender": null,
      ""
          'date': DateFormat('dd/MM/yyyy').format(date),
      "path":
          "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
    });
    print('done');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ParentLogin()));
  }

  Future<void> getData() async {
    names();
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");
    });
    print("SharedPreference Data: $ID");
  }

  void _showDaycareDetail(BuildContext context, String name, String place,
      String phone, String certificate, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                place,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                phone,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return View_cirtificate(certificate);
                      },
                    ));
                  },
                  child: Text("CERTIFICATE")),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Enrolllparent(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Back",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 40),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("DaycareRegister")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFEE364A),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          final enroll = snapshot.data?.docs
                  ?.where((doc) => doc["Username"]
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery))
                  .toList() ??
              [];
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Daycares',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: .95,
                    ),
                    itemCount: enroll.length,
                    itemBuilder: (context, index) {
                      final doc = enroll[index];
                      final isSelected = selectedDaycareId == doc.id;

                      return GestureDetector(
                        onTap: () {
                          _showDaycareDetail(
                            context,
                            doc["Username"],
                            doc["PreschoolAddress"],
                            doc["Phone"],
                            doc["certificate"],
                            doc.id,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isSelected
                                  ? [Colors.blue.shade200, Colors.blue.shade400]
                                  : [
                                      Colors.green.shade200,
                                      Colors.green.shade400
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Text(
                                  //   "",
                                  //   style: GoogleFonts.poppins(
                                  //       color: Colors.white, fontSize: 12),
                                  //   maxLines: 1,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  Text(
                                    doc["Username"],
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Place:",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    doc["PreschoolAddress"],
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    doc["Phone"],
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Center(
                                child: Radio<String>(
                                  value: doc.id,
                                  groupValue: selectedDaycareId,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDaycareId = value!;
                                      print(selectedDaycareId);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: selectedDaycareId == null
                        ? null
                        : () {
                            // Handle the next button press
                            ParentReg();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "REGISTER",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
