import 'package:tiny/logo/select_categoryfor%20reg.dart';
import 'package:tiny/parents/parent_dr.dart';
import 'package:tiny/parents/parent_food.dart';
import 'package:tiny/parents/parent_staff.dart';
import 'package:tiny/parents/tab%20bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentHome extends StatefulWidget {
  const ParentHome({super.key});

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Center(child: Text("Home",style: GoogleFonts.ubuntu( color: Color(0xFFC24A6B)))) ,

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: InkWell(onTap: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => SelectCategoryreg()));
        //     },
        //       child: Container(
        //         height: 50,
        //         width: 105,
        //         decoration: BoxDecoration(boxShadow: [
        //           BoxShadow(
        //               offset: Offset(0, 3),
        //               color: Colors.black45,
        //               spreadRadius: 2,
        //               blurRadius: 3),
        //         ], borderRadius: BorderRadius.circular(10), color:Color(0xFFBD1010),),
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 5,bottom: 2),
        //           child: Row(
        //             children: [
        //               Text(
        //                 "Logout",
        //                 style:
        //                     GoogleFonts.inriaSerif(fontSize: 20, color: Colors.white),
        //               ),
        //               Icon(Icons.logout,color: Colors.white,)
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox( height: MediaQuery.of(context).size.height * .055,),
            InkWell(onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParentFood()));
            },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(229, 197, 53, 1),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          color: Colors.black45,
                          spreadRadius: 2,
                          blurRadius: 3)
                    ]),
                height: MediaQuery.of(context).size.height * .16,
                width: MediaQuery.of(context).size.width * .90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/food1.png"),
                    Text(
                      "FOOD",
                      style: GoogleFonts.irishGrover(
                          fontSize: 70, color: Color.fromRGBO(250, 213, 179, 1)),
                    )
                  ],
                ),
              ),
            ),
            // SizedBox( height: MediaQuery.of(context).size.height * .03,),
            InkWell(onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ParentStaff()));
            },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(195, 27, 45, 1),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          color: Colors.black45,
                          spreadRadius: 2,
                          blurRadius: 3)
                    ]),
                height: MediaQuery.of(context).size.height * .16,
                width: MediaQuery.of(context).size.width * .90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/board.png"),
                    Text(
                      "TEACHER",
                      style: GoogleFonts.irishGrover(
                          fontSize: 50, color: Color.fromRGBO(251, 149, 160, 1)),
                    )
                  ],
                ),
              ),
            ),
            // SizedBox( height: MediaQuery.of(context).size.height * .0450,),
            InkWell(onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Tabbar()));
            },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(16, 78, 133, 1),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          color: Colors.black45,
                          spreadRadius: 2,
                          blurRadius: 3)
                    ]),
                height: MediaQuery.of(context).size.height * .160,
                width: MediaQuery.of(context).size.width * .90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/drpic.png"),
                    Text(
                      "DOCTOR",
                      style: GoogleFonts.irishGrover(
                          fontSize: 60, color: Color.fromRGBO(135, 172, 207, 1)),
                    )
                  ],
                ),
              ),
            )],
        ),
      ),
    );
  }
}
