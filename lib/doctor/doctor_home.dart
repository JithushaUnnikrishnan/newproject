import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/logo/select_categoryfor%20reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appointmentdr.dart';
import 'drRequestpage.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  var ID;

  @override
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

  DocumentSnapshot? Doctorhome;

  Getfirebase() async {
    Doctorhome = await FirebaseFirestore.instance.collection("DoctorReg").doc(ID).get();
    print("done");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: Color.fromRGBO(147, 180, 209, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(147, 180, 209, 1),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectCategoryreg()),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Icon(
                              Icons.logout,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
            ),
            FutureBuilder(
              future: Getfirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF93B4D1),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Error${snapshot.error}");
                }

                return Positioned(
                  top: 120,
                  left: 53,
                  child: Material(
                    elevation: 10,
                    child: Container(
                      width: 312,
                      height: 124,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .09,
                              width: MediaQuery.of(context).size.width * .15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(Doctorhome!["path"]),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            Doctorhome!["Username"],
                            style: GoogleFonts.holtwoodOneSc(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 300,
              left: 53,
              right: 53,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrAppointments()),
                      );
                    },
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            color: Colors.grey,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFDBDBF1),
                      ),
                      child: Center(
                        child: Text(
                          "Appointments",
                          style: GoogleFonts.inriaSerif(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorRequest(id: ID)),
                      );
                    },
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            color: Colors.grey,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFDBDBF1),
                      ),
                      child: Center(
                        child: Text(
                          "Requests",
                          style: GoogleFonts.inriaSerif(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
