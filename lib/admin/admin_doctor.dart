import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Certificates.dart';
import 'admin_drrequest.dart';
import 'certificateaccept.dart';

class AdminDoctor extends StatefulWidget {
  const AdminDoctor({super.key});

  @override
  State<AdminDoctor> createState() => _AdminDoctorState();
}

class _AdminDoctorState extends State<AdminDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black,
          backgroundColor: Color.fromRGBO(54, 151, 238, 1),
          toolbarHeight: 104,
          title: Container(
              child: Row(
            children: [
              Text(
                "Requests",
                style: GoogleFonts.inriaSerif(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdmindrRequest()));
                },
                child: Text(
                  "Doctor List",
                  style: GoogleFonts.inriaSerif(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ))),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("DoctorReg")
              .where("status", isEqualTo: 0)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error:${snapshot.error}"));
            }
            final Doctor = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: Doctor.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .03,
                          height: MediaQuery.of(context).size.height * .2,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            Doctor[index]["path"],
                          ),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 100,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(30),
                        //       image: DecorationImage(
                        //         image: AssetImage(
                        //           "assets/drimage.png",
                        //         ),
                        //         fit: BoxFit.cover,
                        //       )),
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .045,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Doctor[index]["Username"],
                              style: GoogleFonts.inriaSerif(fontSize: 20),
                            ),
                            Text(
                              Doctor[index]["officeaddress"],
                            ),
                            Text(
                              Doctor[index]["qualification"],
                            ),
                            Text(
                              Doctor[index]["specialization"],
                            ),
                            Text(
                              Doctor[index]["experience"],
                            ),
                            // Container(
                            //   width: 200,
                            //   height: 300,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.grey),
                            //     borderRadius: BorderRadius.circular(10),
                            //     image: DecorationImage(
                            //       image: NetworkImage(Doctor[index]["certificateUrl"]),
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AcceptCerti(
                                              id: Doctor[index].id)));
                                },
                                child: Text("View Certificate")),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .1),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection("DoctorReg")
                                          .doc(Doctor[index].id)
                                          .update({"status": 2});
                                    });
                                  },
                                  child: Container(
                                    height: 36,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(
                                          233,
                                          23,
                                          23,
                                          1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              color: Colors.black45)
                                        ]),
                                    child: Center(
                                        child: Text(
                                      "Reject",
                                      style: GoogleFonts.inriaSerif(
                                          fontSize: 20, color: Colors.white),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .0150,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection("DoctorReg")
                                          .doc(Doctor[index].id)
                                          .update({"status": 1});
                                    });
                                  },
                                  child: Container(
                                    height: 36,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              color: Colors.black45)
                                        ]),
                                    child: Center(
                                        child: Text(
                                      "Accept",
                                      style: GoogleFonts.inriaSerif(
                                          fontSize: 20, color: Colors.white),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * .30,
                        // ),
                        // IconButton(onPressed: (){
                        //   setState(() {
                        //     FirebaseFirestore.instance.collection("DoctorReg").doc(Doctor[index].id).delete();
                        //   });
                        // }, icon:  Icon(CupertinoIcons.delete))
                      ],
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
