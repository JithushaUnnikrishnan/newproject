import 'package:tiny/admin/parent%20status.dart';
import 'package:flutter/material.dart';

import '../admin/Admin_parentpage.dart';
import '../admin/admin_daycare.dart';
import '../logo/logo_page.dart';
import 'ad_home.dart';



class AdTabbar extends StatefulWidget {
  const AdTabbar({super.key});

  @override
  State<AdTabbar> createState() => _AdTabbarState();
}

class _AdTabbarState extends State<AdTabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            elevation: 10,
            shadowColor: Colors.black,
            backgroundColor: Color(0xFF93B4D1),
            toolbarHeight: 104,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogoPage()));},
                  icon:
                   Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  AdminHome(),
                  Parentview(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(119, 164, 204, 1),
            ),
            tabs: [
              Tab(
                child: Text(
                  'Daycare',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Parent',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
