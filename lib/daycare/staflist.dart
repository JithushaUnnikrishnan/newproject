// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class StaffList extends StatefulWidget {
//   const StaffList({super.key});
//
//   @override
//   State<StaffList> createState() => _StaffListState();
// }
//
// class _StaffListState extends State<StaffList> {
//   var name;
//
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences spref = await SharedPreferences.getInstance();
//     setState(() {
//       name = spref.getString("name");
//     });
//     print("sharedPreference Data get");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  FutureBuilder(
//         future:
//         FirebaseFirestore.instance.collection("babysiiterReg").where("daycarename",isEqualTo: name).get(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator(
//               color: Color(0xFF750A64),
//             ));
//           }
//           if (snapshot.hasError) {
//             return Text("Error:${snapshot.error}");
//           }
//           final Staff = snapshot.data?.docs ?? [];
//           return ListView.builder(
//             itemCount: Staff.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {},
//                     child: Card(
//                       child: ListTile(
//                           title: Text(Staff[index]["UserName"],
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, color: Colors.black)),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Staff[index]["qualification"],
//                                   style: GoogleFonts.inriaSerif()),
//                               Text(Staff[index]["phonenumber"],
//                                   style: GoogleFonts.inriaSerif()),
//                             ],
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // IconButton(
//                               //   onPressed: () {
//                               //     // Navigator.push(
//                               //     //     context,
//                               //     //     MaterialPageRoute(
//                               //     //         builder: (context) => StaffEdit(
//                               //     //           id: Staff[index].id,
//                               //     //         )));
//                               //   },
//                               //   icon: Icon(Icons.edit),
//                               // ),
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       FirebaseFirestore.instance
//                                           .collection("babysiiterReg")
//                                           .doc(Staff[index].id)
//                                           .delete();
//                                     });
//                                   },
//                                   icon: Icon(CupertinoIcons.delete))
//                             ],
//                           )),
//                     ),
//                   ));
//             },
//           );
//         },
//       ));
//
//   }
// }
