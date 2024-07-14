// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiny/babysitters/healthrecordjeni.dart';
// // import 'package:demo/babysitters/mychildren%20home%20daily%20helth%20buton.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:scroll_date_picker/scroll_date_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Daily healthbt.dart';
// import 'Mychildernphoto.dart';
//
// class HealthView extends StatefulWidget {
//   const HealthView({
//     super.key,
//   });
//
//   @override
//   State<HealthView> createState() => _HealthViewState();
// }
//
// class _HealthViewState extends State<HealthView> {
//   var Stid;
//   var Id;
//
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences spref = await SharedPreferences.getInstance();
//     setState(() {
//       Stid = spref.getString("Studentid");
//       Id = spref.getString("id");
//     });
//     print("sharedPreference Data get");
//   }
//   void showDeleteDialog(BuildContext context, String docId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Deletion"),
//           content: Text("Are you sure you want to delete this  record?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("OK"),
//               onPressed: () {
//                 FirebaseFirestore.instance
//                     .collection("healthrecord add")
//                     .doc(docId)
//                     .delete();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('healthrecord add')
//           .where("StudentId", isEqualTo: Stid)
//           .where("Teacherid", isEqualTo: Id)
//           .snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator(
//             color: Colors.purple,
//           ));
//         }
//         if (snapshot.hasError) {
//           return Text("Error${snapshot.error}");
//         }
//         final health = snapshot.data?.docs ?? [];
//         return Scaffold(
//           appBar: AppBar(
//               automaticallyImplyLeading: false,
//               title: Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => TeacherChildprofile()));
//                       },
//                       child: Icon(Icons.arrow_back)),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 70),
//                     child: Text("Health Record",
//                         style: GoogleFonts.ubuntu(color: Color(0xFFC24A6B))),
//                   ),
//                 ],
//               )),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => HealthRecord()));
//             },
//             child: Text("ADD"),
//           ),
//           body: ListView.builder(
//             itemCount: health.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 50, top: 20, right: 50),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             Text("Date: "),
//                             Text(
//                               health[index]["date"],
//                             )
//                           ],
//                         ),
//                         Spacer(),
//                         IconButton(
//                             onPressed: () {
//                               showDeleteDialog(context, health[index].id);
//                             },
//                             icon: Icon(CupertinoIcons.delete))
//                       ],
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .02,
//                     ),
//                     Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Height",
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               "Weight",
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               "Growth Rate ",
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               "Temperature",
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               health[index]["Height"],
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               health[index]["weight"],
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               health[index]["Growth Rate"],
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                             Text(
//                               health[index]["Temperature"],
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, height: 2),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Divider(),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'healthrecordjeni.dart'; // Assuming this is your add health record screen

class HealthView extends StatefulWidget {
  const HealthView({Key? key}) : super(key: key);

  @override
  State<HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  var stId;
  var id;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      stId = spref.getString("Studentid") ?? "";
      id = spref.getString("id") ?? "";
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.green.shade200,
        elevation: 4,
        shadowColor: Colors.grey,
        title: Text(
          "Health Record",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w900),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.green.shade200,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HealthRecord()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('healthrecord add')
            .where("StudentId", isEqualTo: stId)
            .where("Teacherid", isEqualTo: id)
            .snapshots(),
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
          final healthRecords = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: healthRecords.length,
            itemBuilder: (context, index) {
              var record = healthRecords[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date: ${record['date']}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                showDeleteDialog(context, record.id);
                              },
                              icon: Icon(CupertinoIcons.delete),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _buildHealthInfo("Height", record['Height']),
                        _buildHealthInfo("Weight", record['weight']),
                        _buildHealthInfo("Growth Rate", record['Growth Rate']),
                        _buildHealthInfo("Temperature", record['Temperature']),
                      ],
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

  Widget _buildHealthInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
