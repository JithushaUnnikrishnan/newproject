import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/dayEdit.dart';
import 'package:tiny/logo/select_categoryfor%20reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logo/logo_page.dart';

class DaycareProfile extends StatefulWidget {
  const DaycareProfile({super.key});

  @override
  State<DaycareProfile> createState() => _DaycareProfileState();
}

class _DaycareProfileState extends State<DaycareProfile> {
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

  DocumentSnapshot? Daycare;

  Getfirebase() async {
    Daycare = await FirebaseFirestore.instance
        .collection("DaycareRegister")
        .doc(ID)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getfirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.purple,
          ));
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green.shade200,
            toolbarHeight: 122,
            elevation: 6,
            shadowColor: Colors.grey,
            shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80))),
            title: Center(
              child: Text(
                "Profile",
                style: GoogleFonts.inriaSerif(
                  fontSize: 38,

                ),
              ),
            ),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.building_2_fill,color: Colors.grey,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      Text('Name',
                          style: GoogleFonts.inriaSerif(color: Colors.grey,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .9,

                      child: Text(Daycare!["Username"],
                          style: GoogleFonts.inriaSerif(
                            fontSize: 20,
                          )),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Row(
                    children: [
                      Icon(Icons.report,color: Colors.grey,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      Text('Address',
                          style: GoogleFonts.inriaSerif(color: Colors.grey,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),


                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .9,

                      child: Text(Daycare!["PreschoolAddress"],
                          style: GoogleFonts.inriaSerif(
                            fontSize: 18,
                          )),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Row(
                    children: [
                      Icon(Icons.call,color: Colors.grey,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      Text('Phone',
                          style: GoogleFonts.inriaSerif(color: Colors.grey,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox( width: MediaQuery.of(context).size.width * .9,
                      child: Text(Daycare!["Phone"],
                          style: GoogleFonts.inriaSerif(
                            fontSize: 20,
                          )),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 90),
                    child: InkWell(onTap: (){
                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DaycareEdit()));
                    },
                      child: Container(
                        child: Center(
                            child: Text("Edit Profile",
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white, fontSize: 20))),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF3FA035),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      child: InkWell(onTap: (){
                        Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogoPage()));
                      },
                        child: Container(
                            child: Center(
                                child: Text("Logout",
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.white, fontSize: 20))),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFC65264),
                            )),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
