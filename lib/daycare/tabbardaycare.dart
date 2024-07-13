// import 'package:demo/daycare/staflist.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'daybottombutn.dart';
// import 'daycare_staff.dart';
//
// class DaycareTabbar extends StatefulWidget {
//   const DaycareTabbar({super.key});
//
//   @override
//   State<DaycareTabbar> createState() => _DaycareTabbarState();
// }
//
// class _DaycareTabbarState extends State<DaycareTabbar> {
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(
//       child: DefaultTabController(
//         length: 2,
//         initialIndex: 0,
//         child: Scaffold(
//             appBar: AppBar(
//                 automaticallyImplyLeading: false,
//                 backgroundColor: Color.fromRGBO(117, 10, 100, 1),
//                 toolbarHeight: 122,
//                 elevation: 6,
//                 shadowColor: Colors.grey,
//                 shape: ContinuousRectangleBorder(
//                     borderRadius:
//                     BorderRadius.only(bottomLeft: Radius.circular(80))),
//                 title: Row(
//                   children: [
//                     InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => DayBottomButton()));
//                         },
//                         child: Icon(Icons.arrow_back)),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * .2,
//                     ),
//                     Text(
//                       "My Staff",
//                       style: GoogleFonts.inriaSerif(
//                         fontSize: 38,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 )),
//             // appBar: AppBar(
//             //   leading: IconButton(
//             //       onPressed: () {
//             //         Navigator.pop(context);
//             //       },
//             //       icon: Icon(CupertinoIcons.back,
//             //           color: Color.fromRGBO(194, 74, 107, 1))),
//             //   title: Padding(
//             //     padding: const EdgeInsets.only(left: 100, top: 10),
//             //     child: Container(
//             //       child: Text(
//             //         "Artists",
//             //         style: TextStyle(
//             //             fontSize: 25, color: Color.fromRGBO(194, 74, 107, 1)),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             body: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
//                   child: Container(
//                     height: 50,
//                     // width: 330.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white),
//                     child: TabBar(
//                       labelColor: Colors.white,
//                       unselectedLabelColor: Colors.black,
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicator: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color.fromRGBO(
//                               117, 10, 100, 1
//                           )),
//                       tabs: [
//                         Tab(
//                             child: Text(
//                               'Added Staff',
//                               style: TextStyle(
//                                 // color: Colors.white,
//                                 fontSize: 16,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w500,
//                                 height: 0,
//                               ),
//                             )),
//                         Tab(
//                             child: Text(
//                               'Staff List',
//                               style: TextStyle(
//                                 // color: Colors.black,
//                                 fontSize: 16,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w500,
//                                 height: 0,
//                               ),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(children: [
//                     // DaycareStaff(),
//                     // StaffList(),
//                   ]),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
