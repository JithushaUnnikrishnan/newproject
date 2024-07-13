import 'package:tiny/daycare/daycare_home.dart';
import 'package:tiny/daycare/daycare_profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayBottomButton extends StatefulWidget {
  const DayBottomButton({super.key});

  @override
  State<DayBottomButton> createState() => _DayBottomButtonState();
}

class _DayBottomButtonState extends State<DayBottomButton> {
  int currentindex = 0;
  final pages = [
    const DaycareHome(),
    const DaycareProfile(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (newIndex) {
          setState(() {
            currentindex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_crop_circle_fill,
                color: Colors.black,
              ),
              label: 'Profile'),
        ],
        selectedItemColor: Color.fromRGBO(191, 68, 116, 1),
        unselectedItemColor: Color.fromRGBO(143, 154, 163, 1),
        selectedLabelStyle: TextStyle(color: Color.fromRGBO(191, 68, 116, 1)),
      ),
    );
  }
}
