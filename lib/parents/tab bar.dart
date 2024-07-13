import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:tiny/parents/parent_dr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'book_page.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PBottomButton()));
                    },
                    icon: Icon(Icons.arrow_back)),
                elevation: 20,
                shadowColor: Colors.black,
                backgroundColor: Color.fromRGBO(
                  119,
                  164,
                  204,
                  1,
                ),
                toolbarHeight: 154,
                automaticallyImplyLeading: false,
                title: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/drpic.png"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          Text(
                            "DOCTOR",
                            style: GoogleFonts.irishGrover(
                                fontSize: 40, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            // appBar: AppBar(
            //   leading: IconButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       icon: Icon(CupertinoIcons.back,
            //           color: Color.fromRGBO(194, 74, 107, 1))),
            //   title: Padding(
            //     padding: const EdgeInsets.only(left: 100, top: 10),
            //     child: Container(
            //       child: Text(
            //         "Artists",
            //         style: TextStyle(
            //             fontSize: 25, color: Color.fromRGBO(194, 74, 107, 1)),
            //       ),
            //     ),
            //   ),
            // ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Container(
                    height: 50,
                    // width: 330.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(
                            119,
                            164,
                            204,
                            1,
                          )),
                      tabs: [
                        Tab(
                            child: Text(
                          'Doctors',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        )),
                        Tab(
                            child: Text(
                          'Booked List',
                          style: TextStyle(
                            // color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    ParentBooking(),
                    SuccessPage(),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
