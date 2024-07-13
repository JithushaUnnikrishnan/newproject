import 'package:tiny/babysitters/babysitters_login.dart';
import 'package:tiny/doctor/login_doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../admin/login_page.dart';
import '../daycare/daycare_login.dart';
import '../daycare/daycare_register.dart';
import '../logo/logo_page.dart';
import '../parents/parent_login.dart';
import '../parents/signup_parent.dart';

class SelectCategoryreg extends StatefulWidget {
  const SelectCategoryreg({Key? key}) : super(key: key);

  @override
  _SelectCategoryregState createState() => _SelectCategoryregState();
}

class _SelectCategoryregState extends State<SelectCategoryreg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2EBF0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              "Select UserType",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  buildCategoryCard("Parent", Color(0xFF6ED2F8), ParentLogin(),
                      Icons.person),
                  buildCategoryCard("Daycare", Color(0xFFFFA726),
                      DaycareLogin(), Icons.child_care),
                  buildCategoryCard("Teacher",Color(0xFF7FFFD4), BabysitterLogin(),
                      Icons.school),
                  buildCategoryCard("Doctor", Color(0xFFD8BFD8), DoctorLogin(),
                      Icons.medical_services),
                ],
              ),

            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLogin()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color:Color(0xFF4682B4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Admin",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard(
      String text, Color color, Widget targetPage, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
