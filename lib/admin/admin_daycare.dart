import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/admin/certificateview.dart';

class AdminDaycare extends StatefulWidget {
  const AdminDaycare({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<AdminDaycare> createState() => _AdminDaycareState();
}

class _AdminDaycareState extends State<AdminDaycare> {
  late Future<DocumentSnapshot> _daycareFuture;

  @override
  void initState() {
    super.initState();
    _daycareFuture = getDaycareDetails();
  }

  Future<DocumentSnapshot> getDaycareDetails() async {
    return await FirebaseFirestore.instance
        .collection('DaycareRegister')
        .doc(widget.id)
        .get();
  }

  void acceptDaycare() {
    FirebaseFirestore.instance
        .collection("DaycareRegister")
        .doc(widget.id)
        .update({"status": 1}).then((value) {
      setState(() {
        _daycareFuture = getDaycareDetails(); // Refresh UI after update
      });
    }).catchError((error) => print("Failed to accept daycare: $error"));
  }

  void rejectDaycare() {
    FirebaseFirestore.instance
        .collection("DaycareRegister")
        .doc(widget.id)
        .update({"status": 2}).then((value) {
      setState(() {
        _daycareFuture = getDaycareDetails(); // Refresh UI after update
      });
    }).catchError((error) => print("Failed to reject daycare: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Color.fromRGBO(119, 164, 204, 1),
        toolbarHeight: 104,
        title: Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Text(
            "Daycare",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _daycareFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          var daycaview = snapshot.data!;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            padding: EdgeInsets.all(20),
            height: 550,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(119, 164, 204, 1),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0, 2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    daycaview["path"],
                    height: 100,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    children: [
                      Text(
                        "Daycare:",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        daycaview["Username"],
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.grey.shade300),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Place:",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      daycaview["PreschoolAddress"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Phone:",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      daycaview["Phone"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Email:",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      daycaview["Email"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Certificateadminview(
                                  path: daycaview["certificate"],
                                )));
                  },
                  child: Text(
                    "CERTIFICATE",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Spacer(),
                daycaview["status"] == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: acceptDaycare,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Accept",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            onPressed:
                                daycaview["status"] == 1 ? null : rejectDaycare,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Reject",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    : daycaview["status"] == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  "Accepted",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        : Text("Rejected",style: TextStyle(color: Colors.red),),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
