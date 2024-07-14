import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'daybottombutn.dart';
import 'daycare_stafadd.dart';
import 'daycarestafview.dart';
import 'staffedit.dart';

class DaycareStaff extends StatefulWidget {
  const DaycareStaff({super.key});

  @override
  State<DaycareStaff> createState() => _DaycareStaffState();
}

class _DaycareStaffState extends State<DaycareStaff> {
  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this staff member?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("DaycareAddStaff")
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var ID;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade200,
        toolbarHeight: 122,
        elevation: 6,
        shadowColor: Colors.grey,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DayBottomButton()));
              },
              child: Icon(Icons.arrow_back),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            Text(
              "My Staff",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade200,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DaycareStafadd()));
        },
        child: Text("ADD"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("DaycareAddStaff")
            .where("DaycareId", isEqualTo: ID)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF750A64),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text("Error:${snapshot.error}");
          }
          final Staff = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Staff.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    child: ListTile(
                      title: Text(
                        Staff[index]["StaffName"],
                        style: GoogleFonts.inriaSerif(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Staff[index]["Qualification"],
                            style: GoogleFonts.inriaSerif(),
                          ),
                          Text(
                            Staff[index]["Phone"],
                            style: GoogleFonts.inriaSerif(),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StaffEdit(
                                    id: Staff[index].id,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(context, Staff[index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
