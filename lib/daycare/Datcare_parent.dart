// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo/daycare/daycare_parent%20viewpage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DaycareParent extends StatefulWidget {
//   const DaycareParent({super.key});
//
//   @override
//   State<DaycareParent> createState() => _DaycareParentState();
// }
//
// class _DaycareParentState extends State<DaycareParent> {
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(117, 10, 100, 1),
//           toolbarHeight: 122,
//           elevation: 6,
//           shadowColor: Colors.grey,
//           shape: ContinuousRectangleBorder(
//               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
//           title: Text(
//             "Child Request",
//             style: GoogleFonts.inriaSerif(
//               fontSize: 38,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         body: FutureBuilder(
//           future: FirebaseFirestore.instance
//               .collection("ParentRegister")
//               .where("Daycare name", isEqualTo: name)
//               .get(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text("Error:${snapshot.error}");
//             }
//             final request = snapshot.data?.docs ?? [];
//             return ListView.builder(
//               itemCount: request.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Card(
//                       child: ListTile(
//                     leading: Text(
//                       request[index]["Child name"],
//                       style: GoogleFonts.inriaSerif(
//                         fontSize: 30,
//                         color: Colors.black,
//                       ),
//                     ),
//                     trailing: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     RequestAccept(id: request[index].id)));
//                       },
//                       child: Container(
//                           height: 40,
//                           width: 74,
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     offset: Offset(0, 3),
//                                     spreadRadius: 2,
//                                     blurRadius: 2,
//                                     color: Colors.black45)
//                               ],
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.blue),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "View",
//                               style: GoogleFonts.inriaSerif(
//                                   fontSize: 20, color: Colors.white),
//                             ),
//                           )),
//                     ),
//                   )),
//                 );
//               },
//             );
//           },
//         ));
//   }
// }
