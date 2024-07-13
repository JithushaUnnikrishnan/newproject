import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:tiny/parents/parent_dailytask.dart';
import 'package:tiny/parents/parent_healthrecord.dart';
import 'package:tiny/parents/parent_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentBabyprofile extends StatefulWidget {
  const ParentBabyprofile({super.key});

  @override
  State<ParentBabyprofile> createState() => _ParentBabyprofileState();
}

class _ParentBabyprofileState extends State<ParentBabyprofile> {
  var ID;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  DocumentSnapshot? mychild;

  Getfirebase() async {
    mychild = await FirebaseFirestore.instance
        .collection("ParentRegister")
        .doc(ID)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder(
              future: Getfirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF0E6174),
                  ));
                }
                if (snapshot.hasError) {
                  return Text("Error${snapshot.error}");
                }
                return Positioned(
                  left: 25, // Position the first image outside the container
                  top: 135,
                  child: Container(
                    width: 367,
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Colors.black45)
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 40),
                          child: Column(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .09,
                                  width:
                                      MediaQuery.of(context).size.width * .15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              NetworkImage(mychild!["path"])))),
                              Text(mychild!["Child name"],
                                  style: GoogleFonts.inriaSerif(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text(mychild!["Date of birth"],
                                  style: GoogleFonts.inriaSerif(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*.02,),

                              Text('My Child',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .03),
                              SizedBox(
                                width: 190,
                                child: Text(mychild!["Address"],
                                    style: GoogleFonts.inriaSerif(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Text(mychild!["Phone"],
                                  style: GoogleFonts.inriaSerif(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Parent_healthRecord();
                        },
                      ));
                    },
                    child: Container(
                      width: 162,
                      height: 85,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: Colors.black45)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(239, 96, 216, 1),
                      ),
                      child: Center(
                        child: Text('Health Record',
                            style: GoogleFonts.inriaSerif(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParentDailytask()));
                    },
                    child: Container(
                        width: 162,
                        height: 85,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.black45)
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(100, 202, 98, 1),
                        ),
                        child: Center(
                          child: Text('Daily Task',
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 20),
              child: Image.asset(
                'assets/stckpic.png',
                width: 350,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
