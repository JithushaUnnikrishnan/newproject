
import 'package:tiny/parents/Parent_babyprofile.dart';
import 'package:tiny/parents/parent_activity.dart';
import 'package:tiny/parents/parent_home.dart';
import 'package:tiny/parents/pchildprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PBottomButton extends StatefulWidget {
  const PBottomButton({super.key});

  @override
  State<PBottomButton> createState() => _PBottomButtonState();
}

class _PBottomButtonState extends State<PBottomButton> {
  int currentindex = 0;
  final pages = [
    const ParentHome(),
    const EnrollChild(),
    ParentActivity(),
    const ParentBabyprofile(),


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
          BottomNavigationBarItem(icon: Icon(Icons.check_circle,color: Colors.black,),
          label: 'Activity'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.child_care,color: Colors.black,),label: 'my child')
        ],
        selectedItemColor: Color.fromRGBO(191, 68, 116, 1),

        unselectedItemColor: Color.fromRGBO(143, 154, 163, 1),
        selectedLabelStyle: TextStyle(color: Color.fromRGBO(191, 68, 116, 1)),

      ),
    );
  }
}