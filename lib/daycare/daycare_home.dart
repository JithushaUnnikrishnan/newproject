import 'package:flutter/material.dart';
import 'package:tiny/daycare/daycare_staff.dart';
import 'package:tiny/daycare/daycare_children.dart';
import 'package:tiny/daycare/daycare_activity.dart';

import 'package:google_fonts/google_fonts.dart';

import 'draddpagebydaycare.dart';
import 'DAycarefoodview.dart';

class DaycareHome extends StatelessWidget {
  const DaycareHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 122,
        backgroundColor: Color.fromRGBO(117, 10, 100, 1),
        elevation: 10,
        shadowColor: Colors.black,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Adjust with your logo path
              height: 60,
              width: 60,
            ),
            SizedBox(width: 10),
            Text(
              "My School",
              style: GoogleFonts.inriaSerif(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            buildCategoryCard(
              context,
              "Staff",
              Color.fromRGBO(241, 210, 210, 1),
              DaycareStaff(),
              Icons.people_alt_outlined,
            ),
            buildCategoryCard(
              context,
              "Children",
              Color.fromRGBO(207, 201, 244, 1),
              DaycareChildren(),
              Icons.child_care,
            ),
            buildCategoryCard(
              context,
              "Activity",
              Color.fromRGBO(242, 215, 133, 1),
              DaycareActivity(),
              Icons.sports_soccer,
            ),
            buildCategoryCard(
              context,
              "Food ",
              Color.fromRGBO(255, 99, 130, 1),
              DaycareFoodview(),
              Icons.food_bank_outlined,
            ),
            buildCategoryCard(
              context,
              "Doctor",
              Color.fromRGBO(225, 102, 130, 1),
              DrAdd(),
              Icons.local_hospital,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context,
      String title,
      Color color,
      Widget targetPage,
      IconData iconData,
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.9),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.inriaSerif(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:demo/daycare/DAycarefoodview.dart';
// import 'package:demo/daycare/Datcare_parent.dart';
// import 'package:demo/daycare/daycare_activity.dart';
// import 'package:demo/daycare/daycare_children.dart';
// import 'package:demo/daycare/daycare_food.dart';
// import 'package:demo/daycare/daycare_staff.dart';
// import 'package:demo/daycare/tabbardaycare.dart';
// import 'package:demo/logo/select_categoryfor%20reg.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
//
// class DaycareHome extends StatefulWidget {
//   const DaycareHome({super.key});
//
//   @override
//   State<DaycareHome> createState() => _DaycareHomeState();
// }
//
// class _DaycareHomeState extends State<DaycareHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 122,
//         backgroundColor: Color.fromRGBO(117, 10, 100, 1),
//         elevation: 10,
//         shadowColor: Colors.black,
//         shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
//         title: Center(child: Text("My School",style: GoogleFonts.inriaSerif(color: Colors.white,fontSize: 30))),
//
//
//       ),
//       body:  Padding(
//         padding: const EdgeInsets.only(left: 40),
//         child: Column(
//
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // SizedBox(height: MediaQuery.of(context).size.height * 0.075),
//               InkWell(onTap: (){
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DaycareStaff()));
//               },
//                 child: Container(
//                   height:  MediaQuery.of(context).size.height * 0.09,width: MediaQuery.of(context).size.width * 0.75,
//                   decoration:  BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(241, 210, 210, 1),
//                           boxShadow: [
//                 BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 2,color: Colors.black45)
//                           ]
//                       ),
//                   child: Center(child: Text("My Staff",style: GoogleFonts.inriaSerif(color: Colors.black,fontSize: 40))),
//                 ),
//               ),
//               // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//               // InkWell(onTap: (){
//               //   Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //           builder: (context) => DaycareParent()));
//               // },
//               //   child: Container(
//               //     height: 72,width: 312,
//               //     decoration:  BoxDecoration(
//               //         borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(205, 242, 199, 1),
//               //         boxShadow: [
//               //           BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 2,color: Colors.black45)
//               //         ]
//               //     ),
//               //     child: Text("Children Request",style: GoogleFonts.inriaSerif(color: Colors.black,fontSize: 33)),
//               //   ),
//               // ),
//               // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//               InkWell(onTap: (){
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DaycareChildren()));
//               },
//                 child: Container(
//                   height:  MediaQuery.of(context).size.height * 0.09,width: MediaQuery.of(context).size.width * 0.75,
//                   decoration:  BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(207, 201, 244, 1),
//                       boxShadow: [
//                         BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 2,color: Colors.black45)
//                       ]
//                   ),
//                   child: Center(child: Text("Children",style: GoogleFonts.inriaSerif(color: Colors.black,fontSize: 40))),
//                 ),
//               ),
//               // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//               InkWell(onTap: (){
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DaycareActivity()));
//               },
//                 child: Container(
//                   height:  MediaQuery.of(context).size.height * 0.09,width: MediaQuery.of(context).size.width * 0.75,
//                   decoration:  BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(242, 215, 133, 1),
//                       boxShadow: [
//                         BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 2,color: Colors.black45)
//                       ]
//                   ),
//                   child: Center(child: Text("Activity",style: GoogleFonts.inriaSerif(color: Colors.black,fontSize: 40))),
//                 ),
//               ),
//               // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//               InkWell(onTap: (){
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DaycareFoodview()));
//               },
//                 child: Container(
//                   height:  MediaQuery.of(context).size.height * 0.09,width: MediaQuery.of(context).size.width * 0.75,
//                   decoration:  BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(255, 99, 130, 1),
//                       boxShadow: [
//                         BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 2,color: Colors.black45)
//                       ]
//                   ),
//                   child: Center(child: Text("Food Add",style: GoogleFonts.inriaSerif(color: Colors.black,fontSize: 40))),
//                 ),
//               ),
//
//             ],
//           ),
//       ),
//
//     );
//   }
// }
