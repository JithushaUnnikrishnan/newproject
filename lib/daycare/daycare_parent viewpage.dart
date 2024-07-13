// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo/daycare/Datcare_parent.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class RequestAccept extends StatefulWidget {
//   const RequestAccept({super.key, required this.id});
//   final id;
//
//   @override
//   State<RequestAccept> createState() => _RequestAcceptState();
// }
//
// class _RequestAcceptState extends State<RequestAccept> {
//   DocumentSnapshot? Requestview;
//
//   Getfirebase() async {
//     Requestview = await FirebaseFirestore.instance.collection('ParentRegister').doc(widget.id).get();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Getfirebase(),
//       builder: (context,snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator(
//                 color: Colors.purple,
//               ));
//         }
//         if (snapshot.hasError) {
//           return Text("Error${snapshot.error}");
//         }
// return  Scaffold(
//   body: Stack(
//     children: [
//       Container(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 350),
//           child: InkWell(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DaycareParent()));
//               },
//               child: Icon(Icons.arrow_back)),
//         ),
//         height: 150,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Color(0xFF750A64),
//             borderRadius:
//             BorderRadius.only(bottomLeft: Radius.circular(40)),
//             boxShadow: [
//               BoxShadow(
//                   offset: Offset(0, 2),
//                   spreadRadius: 3,
//                   blurRadius: 4,
//                   color: Colors.black45)
//             ]),
//       ),
//       Positioned(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 160, top: 120),
//             child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                           offset: Offset(1, 4),
//                           spreadRadius: 2,
//                           blurRadius: 4,
//                           color: Colors.grey)
//                     ]),
//                 height: 100,
//                 width: 100,
//                 child: Image.asset('assets/rectgirl.png')),
//           )),
//       Padding(
//         padding: const EdgeInsets.only(top: 250, left: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.person),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .051,
//                 ),
//                 Text(
//                   'Name',
//                   style:
//                   TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 43),
//               child: Text(Requestview!["Child name"]),
//             ),
//             Divider(),
//             Row(
//               children: [
//                 Icon(Icons.location_on),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .051,
//                 ),
//                 Text(
//                   'Address',
//                   style:
//                   TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 43),
//               child: Text(Requestview!['Address']),
//             ),
//             Divider(),
//             Row(
//               children: [
//                 Icon(Icons.calendar_month),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .051,
//                 ),
//                 Text(
//                   'Date of birth',
//                   style:
//                   TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 43),
//               child: Text(Requestview!['Date of birth']),
//             ),
//             Divider(),
//             Row(
//               children: [
//                 Icon(Icons.family_restroom),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .051,
//                 ),
//                 Text(
//                   "Parent Name",
//                   style:
//                   TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 43),
//               child: Text(Requestview!['Parent Name']),
//             ),
//             Divider(),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * .091,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Accept',
//                     style: GoogleFonts.inriaSerif(
//                         fontSize: 20, color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .091,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Reject',
//                     style: GoogleFonts.inriaSerif(
//                         fontSize: 20, color: Colors.white),
//                   ),
//                   style:
//                   ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 )
//               ],
//             )
//           ],
//         ),
//       )
//     ],
//   ),
// );
//       },
//
//     );
//   }
// }
