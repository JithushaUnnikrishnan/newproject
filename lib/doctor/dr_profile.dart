import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/doctor/doctor_bottombuton.dart';
import 'package:tiny/doctor/dr_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  PickedFile? _image;
  bool isloading = false;
  Future<void> _getImage() async {
    setState(() {
      isloading = true;
    });
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = PickedFile(pickedFile.path);
        print("picked image");
        update();
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> update() async {
    try {
      if (_image != null) {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('Dr_images')
            .child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(File(_image!.path));

        final imageURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('DoctorReg')
            .doc(ID)
            .update({
          'path': imageURL,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
          ),
        );
        setState(() {
          isloading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
          ),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating profile'),
        ),
      );
    }
  }
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

  DocumentSnapshot? Doctor;

  Getfirebase() async {
    Doctor =
        await FirebaseFirestore.instance.collection("DoctorReg").doc(ID).get();
    print("done");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getfirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Color(0xFF93B4D1),
          ));
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Color.fromRGBO(
                      147,
                      180,
                      209,
                      1,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DBottomButton()));
                            },
                            child: Icon(Icons.arrow_back)),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorEdit()));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      left: 50,
                      top: 115,
                      child: Material(
                        elevation: 5,
                        child: Container(
                          width: 312,
                          height: 124,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Column(children: [
                                // Doctor!["path"] == "1"
                                //     ? Padding(
                                //         padding: const EdgeInsets.only(
                                //             left: 5, top: 15),
                                //         child: Container(
                                //           height: MediaQuery.of(context).size.height * .09,
                                //             width: MediaQuery.of(context).size.width * .15,
                                //           decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(10),
                                //               image: DecorationImage(fit: BoxFit.fill,
                                //                   image: AssetImage(
                                //                       "assets/m.png"))),
                                //           // child: CircleAvatar(
                                //           //   radius: 50,
                                //           //   backgroundColor: Colors.transparent,
                                //           // ),
                                //         ))
                                isloading
                                    ? CircularProgressIndicator(
                                  color: Color(0xFF93B4D1),
                                )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 15),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * .09,
                                            width: MediaQuery.of(context).size.width * .15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      Doctor!["path"]))),
                                          // child: CircleAvatar(
                                          //   radius: 50,
                                          //   backgroundColor: Colors.transparent,
                                          // ),
                                        )),
                              ]),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .030,
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(Doctor!["Username"],
                                    style: GoogleFonts.holtwoodOneSc(
                                        fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .21,
                    left: MediaQuery.of(context).size.width * .23,
                    child: Container(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _getImage();
                          });
                        },
                        icon: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 300.0, horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text(
                              Doctor!["email"],
                              style: GoogleFonts.inriaSerif(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Icon(Icons.home),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text(
                              Doctor!["homeaddress"],
                              style: GoogleFonts.inriaSerif(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.building_2_fill),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text(
                              Doctor!["officeaddress"],
                              style: GoogleFonts.inriaSerif(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Icon(Icons.school_outlined),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text(
                              Doctor!["qualification"],
                              style: GoogleFonts.inriaSerif(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month_rounded),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text(
                              Doctor!["experience"],
                              style: GoogleFonts.inriaSerif(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Icon(Icons.local_hospital),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Text(
                              Doctor!["specialization"],
                              style: GoogleFonts.inriaSerif(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
