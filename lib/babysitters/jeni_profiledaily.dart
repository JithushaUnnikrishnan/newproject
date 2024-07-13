// import 'package:demo/babysitters/dailyTaskview.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ChildPage extends StatefulWidget {
//   const ChildPage({super.key});
//
//   @override
//   State<ChildPage> createState() => _ChildPageState();
// }
//
// class _ChildPageState extends State<ChildPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Row(
//               children: [
//
//                 Container(
//                   width: 50,
//                   height: 50,
//                   child: Image.asset('assets/girl.png'),
//                 ),
//                 Expanded(
//                   child: ListTile(
//                     title: Text('Jeni',style: GoogleFonts.inriaSerif(fontSize: 20),),
//                     subtitle: Text('Female',style: GoogleFonts.inriaSerif(fontSize: 20),),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 50,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(("Daily Task"),style: GoogleFonts.inriaSerif(fontSize: 20),),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   height: 46,
//                   width: 316,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 3,
//                           offset: Offset(0, 4))
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             decoration: BoxDecoration(
//                               boxShadow: [BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 3,color: Colors.black26)],
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.blue),
//                             width: 75,
//                             height: 35,
//                             child: Center(
//                               child: Text(
//                                 'Upload',
//                                 style: GoogleFonts.inriaSerif(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * .030,
//                 ),
//                 Container(
//                   height: 46,
//                   width: 316,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 3,
//                           offset: Offset(0, 4))
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 boxShadow: [BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 3,color: Colors.black26)],
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.blue),
//                             width: 75,
//                             height: 35,
//                             child: Center(
//                               child: Text(
//                                 'Upload',
//                                 style: GoogleFonts.inriaSerif(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * .030,
//                 ),
//                 Container(
//                   height: 46,
//                   width: 316,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 3,
//                           offset: Offset(0, 4))
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 boxShadow: [BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 3,color: Colors.black26)],
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.blue),
//                             width: 75,
//                             height: 35,
//                             child: Center(
//                               child: Text(
//                                 'Upload',
//                                 style: GoogleFonts.inriaSerif(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height:MediaQuery.of(context).size.height*.44,),
//                 Center(child: ElevatedButton(onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoListPage()));
//                 }, child: Text('Done',style: GoogleFonts.inriaSerif(fontSize:15,color: Colors.white)),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,))
//                 )
//
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
