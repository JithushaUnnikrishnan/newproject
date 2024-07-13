import 'package:tiny/babysitters/babysitter_activity.dart';
import 'package:tiny/babysitters/babysitters_foodmenu.dart';
import 'package:tiny/babysitters/Mychildernphoto.dart';
import 'package:tiny/logo/select_categoryfor%20reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'babysitters_signup.dart';

class BabysitterHome extends StatefulWidget {
  const BabysitterHome({super.key});

  @override
  State<BabysitterHome> createState() => _BabysitterHomeState();
}

class _BabysitterHomeState extends State<BabysitterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/homebaby.png"),
                      fit: BoxFit.fill)),
              // child: Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => SelectCategoryreg()));
              //           },
              //           child: Material(
              //             elevation: 4,
              //             borderRadius: BorderRadius.circular(10),
              //             child: Container(
              //               height: 35,
              //               width: 90,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: Colors.white,
              //               ),
              //               child: Row(
              //                 children: [
              //                   Text(
              //                     " Logout",
              //                     style: GoogleFonts.tinos(
              //                         color: Colors.black,
              //                         fontSize: 15,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   Icon(CupertinoIcons.square_arrow_right),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                      child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BabysitterFoodmenu()));
                    },
                    child: Text(
                      "Menu",
                      style: GoogleFonts.robotoSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: Color.fromRGBO(95, 213, 239, 1),
                        elevation: 10,
                        shadowColor: Colors.black,
                        minimumSize: Size(150, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28))),
                  )),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherActivity()));
                      },
                      child: Text(
                        "Activity",
                        style: GoogleFonts.inriaSerif(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          backgroundColor: Color.fromRGBO(211, 134, 64, 1),
                          minimumSize: Size(150, 100),
                          elevation: 10,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TeacherChildprofile()));
                    },
                    child: Text(
                      "My Children",
                      style: GoogleFonts.robotoSerif(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: Color.fromRGBO(190, 64, 211, 1),
                        minimumSize: Size(150, 100),
                        elevation: 10,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28))),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                // Container(
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       "Logout",
                //       style: GoogleFonts.robotoSerif(
                //           color: Colors.black,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: Color.fromRGBO(81, 150, 188, 0.56),
                //         elevation: 10,
                //         shadowColor: Colors.black,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.home,
      //           color: Colors.black,
      //         ),
      //         label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.person_crop_circle_fill,
      //           color: Colors.black,
      //         ),
      //         label: 'Profile'),
      //   ],
      // ),
    );
  }
}
