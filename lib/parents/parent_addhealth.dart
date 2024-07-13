// import 'package:demo/parents/parent_healthrecord.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AddhealthRecord extends StatefulWidget {
//   const AddhealthRecord({super.key});
//
//   @override
//   State<AddhealthRecord> createState() => _AddhealthRecordState();
// }
//
// class _AddhealthRecordState extends State<AddhealthRecord> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Color.fromRGBO(66, 135, 156, 1), toolbarHeight: 122,
//
//           elevation: 10,
//           shadowColor: Colors.black,
//           shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)))
//       ),
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.width * .07,),
//               Text("Height",style: GoogleFonts.inriaSerif(fontSize: 14),),
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.width * .07,),
//               Text("weight",style: GoogleFonts.inriaSerif(fontSize: 14),),
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.width * .07,),
//               Text("Other",style: GoogleFonts.inriaSerif(fontSize: 14),),
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//
//               SizedBox(height: MediaQuery.of(context).size.height * .075,),
//               Center(
//                 child: InkWell(
//                   onTap: (){
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>Parent_healthRecord()));
//                   },
//                   child: Container(
//                     child: Center(child: Text("Done",style: GoogleFonts.inriaSerif(fontSize: 20,color: Colors.white),)),
//                     height: MediaQuery.of(context).size.height * .050,width: MediaQuery.of(context).size.width * .25,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),boxShadow: [
//                       BoxShadow(
//                           offset: Offset(0, 4),
//                           spreadRadius: 1,
//                           blurRadius: 2,
//                           color: Colors.grey
//                       ),
//                     ],color: Colors.blue
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
