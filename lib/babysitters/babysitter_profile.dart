import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/babysitter_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logo/select_categoryfor reg.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
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
            .child('teacher_images')
            .child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(File(_image!.path));

        final imageURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Daycare AddStaff')
            .doc(id)
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

  var id;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      id = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  DocumentSnapshot? Babysitter;

  Getfirebase() async {
    Babysitter = await FirebaseFirestore.instance
        .collection("Daycare AddStaff")
        .doc(id)
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
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: isloading
                            ? CircularProgressIndicator(
                                color: Color(0xFFC65264),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .09,
                                width: MediaQuery.of(context).size.width * .15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          Babysitter!["path"],
                                        ))),
                              ),
                        trailing: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BabysitterEdit()));
                          },
                          child: Container(
                            height: 28,
                            width: 50,
                            child: Row(
                              children: [
                                Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            Babysitter!['Staff Name'],
                            style: GoogleFonts.inriaSerif(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // subtitle: Padding(
                        //   padding: const EdgeInsets.only(left: 30),
                        //   child: Text(
                        //     Babysitter!["gender"],
                        //     style: GoogleFonts.inriaSerif(
                        //         fontSize: 20, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.building_2_fill),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .02,
                            ),
                            Text(Babysitter!['Daycare Name']),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Icon(CupertinoIcons.home),
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width * .02,
                      //       ),
                      //       Text(Babysitter!['Address']),
                      //     ],
                      //   ),
                      // ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.school),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .02,
                            ),
                            Text(Babysitter!['Qualification']),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.calendar_month),
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width * .02,
                      //       ),
                      //       Text(Babysitter!['experiance']),
                      //     ],
                      //   ),
                      // ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            Text(Babysitter!['Phone']),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.chat_bubble_rounded),
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width * .02,
                      //       ),
                      //       Text(
                      //         Babysitter!['whatsappNumber'],
                      //         style: TextStyle(fontSize: 14),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectCategoryreg()));
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
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 50,
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
        );
      },
    );
  }
}
