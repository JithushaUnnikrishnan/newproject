import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/penroll_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logo/logo_page.dart';
import '../logo/select_categoryfor reg.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EnrollChild extends StatefulWidget {
  const EnrollChild({super.key});

  @override
  State<EnrollChild> createState() => _EnrollChildState();
}

class _EnrollChildState extends State<EnrollChild> {
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
            .child('user_images')
            .child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(File(_image!.path));

        final imageURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('ParentRegister')
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

  DocumentSnapshot? Parentchildprofile;

  Getfirebase() async {
    Parentchildprofile = await FirebaseFirestore.instance
        .collection("ParentRegister")
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
            color: Color(0xFF0E6174),
          ));
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 122,
            backgroundColor: Color.fromRGBO(66, 135, 156, 1),
            shadowColor: Colors.grey,
            elevation: 10,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EnrollEdit()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Edit",
                        style: GoogleFonts.inriaSerif(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .010,
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .060,
              ),
            ],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      // Parentchildprofile!["path"] == '1'
                      //     ? Container(
                      //         height: MediaQuery.of(context).size.height * .09,
                      //         width: MediaQuery.of(context).size.width * .15,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             image: DecorationImage(
                      //                 image: AssetImage("assets/m.png"),
                      //                 fit: BoxFit.fill)),
                      //       )
                      isloading
                          ? CircularProgressIndicator(
                        color: Color(0xFFC65264),
                      )
                          : Container(
                              height: MediaQuery.of(context).size.height * .09,
                              width: MediaQuery.of(context).size.width * .15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          Parentchildprofile!["path"]),
                                      fit: BoxFit.fill)),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Text(
                        "Child Name",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(Parentchildprofile!["Child name"]),
                      Divider(
                        color: Colors.grey,
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(Parentchildprofile!["Address"]),
                      Divider(
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(Parentchildprofile!["Date of birth"]),
                      Divider(
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(
                        "Parent Name",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(Parentchildprofile!["Parent Name"]),
                      // Divider(
                      //   endIndent: 20,
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogoPage()));
                          },
                          child: Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                  Text("Logout",
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.white, fontSize: 20)),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.015,
                                  ),
                                  Icon(
                                    Icons.login_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFC65264),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: 65,
                      left: 35,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              _getImage();
                            });
                          },
                          icon: Icon(Icons.camera_alt_outlined))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
