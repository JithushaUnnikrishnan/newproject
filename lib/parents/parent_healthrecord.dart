// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiny/parents/parent_addhealth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Parent_healthRecord extends StatefulWidget {
//   const Parent_healthRecord({super.key});
//
//   @override
//   State<Parent_healthRecord> createState() => _Parent_healthRecordState();
// }
//
// class _Parent_healthRecordState extends State<Parent_healthRecord> {
//   var ID;
//
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences spref = await SharedPreferences.getInstance();
//     setState(() {
//       ID = spref.getString("id");
//     });
//     print("sharedPreference Data get");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance.collection("healthrecord add").where("StudentId",isEqualTo:ID ).get(),
//       builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF0E6174),
//               ));
//         }
//         if (snapshot.hasError) {
//           return Text("Error${snapshot.error}");
//         }
//         final health = snapshot.data?.docs ?? [];
//     return    Scaffold(
//           appBar: AppBar(
//             backgroundColor:Colors.green.shade200,
//             toolbarHeight: 100,
//             elevation: 6,
//             shadowColor: Colors.grey,
//             shape: ContinuousRectangleBorder(
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
//             title:
//             Text(
//               "Health Record",
//               style: GoogleFonts.poppins(
//                   fontSize: 20, fontWeight: FontWeight.w900),
//             ),
//
//
//           ),
//           body: ListView.builder(
//             itemCount: health.length,
//             itemBuilder: (context, index) {
//               return
//               Padding(
//                 padding: const EdgeInsets.only(left: 50, top: 30, right: 50),
//                 child: Column(
//
//                   children: [
//                     Row(children: [Text("Date:"),Text(health[index]["date"]),IconButton(onPressed: (){setState(() {
//                       FirebaseFirestore.instance
//                           .collection("healthrecord add")
//                           .doc(health[index].id)
//                           .delete();
//                     });}, icon: Icon(CupertinoIcons.delete))],),
//                     Row(
//
//                       children: [
//
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Height",
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               "Weight",
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               "Growth Rate ",
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               "Temperature",
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                         health[index]["Height"],
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                             Text(
//                             health[index]["weight"],
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                             Text(
//                             health[index]["Growth Rate"],
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                             Text(
//               health[index]["Temperature"],
//                               style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     InkWell(
//                     //       onTap: () {
//                     //         Navigator.push(
//                     //             context,
//                     //             MaterialPageRoute(
//                     //                 builder: (context) => AddhealthRecord()));
//                     //       },
//                     //       child: Container(
//                     //         child: Center(
//                     //             child: Text(
//                     //           "Add",
//                     //           style: GoogleFonts.inriaSerif(
//                     //               fontSize: 20, color: Colors.white),
//                     //         )),
//                     //         height: MediaQuery.of(context).size.height * .050,
//                     //         width: MediaQuery.of(context).size.width * .25,
//                     //         decoration: BoxDecoration(
//                     //             borderRadius: BorderRadius.circular(10),
//                     //             boxShadow: [
//                     //               BoxShadow(
//                     //                   offset: Offset(0, 4),
//                     //                   spreadRadius: 1,
//                     //                   blurRadius: 2,
//                     //                   color: Colors.grey),
//                     //             ],
//                     //             color: Colors.blue),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // )
//                     Divider(),
//
//                   ],
//                 ),
//               );
//             },
//
//           ),
//         );
//       },
//
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Parent_healthRecord extends StatefulWidget {
  const Parent_healthRecord({super.key});

  @override
  State<Parent_healthRecord> createState() => _Parent_healthRecordState();
}

class _Parent_healthRecordState extends State<Parent_healthRecord> {
  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this record?"),
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
                    .collection("healthrecord add")
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");
    });
    print("SharedPreferences Data retrieved");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("healthrecord add").where("StudentId", isEqualTo: ID).get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green.shade200,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.red),
            ),
          );
        }
        final health = snapshot.data?.docs ?? [];
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade200,
            toolbarHeight: 100,
            elevation: 6,
            shadowColor: Colors.grey,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
            title: Text(
              "Health Record",
              style: GoogleFonts.inriaSerif(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          body: ListView.builder(
            itemCount: health.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date: ${health[index]["date"]}",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(context, health[index].id);

                            },
                            icon: Icon(CupertinoIcons.delete, color: Colors.red.shade300),
                          ),
                        ],
                      ),
                      Divider(color: Colors.green.shade200),
                      buildHealthInfoRow("Height", health[index]["Height"]),
                      buildHealthInfoRow("Weight", health[index]["weight"]),
                      buildHealthInfoRow("Growth Rate", health[index]["Growth Rate"]),
                      buildHealthInfoRow("Temperature", health[index]["Temperature"]),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildHealthInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
