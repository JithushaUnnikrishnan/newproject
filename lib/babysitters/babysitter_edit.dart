import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/babysitter_activity.dart';
import 'package:tiny/babysitters/babysitter_profile.dart';
import 'package:tiny/babysitters/bs_bottombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BabysitterEdit extends StatefulWidget {
  const BabysitterEdit({
    super.key,
  });

  @override
  State<BabysitterEdit> createState() => _BabysitterEditState();
}

class _BabysitterEditState extends State<BabysitterEdit> {
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
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection("Daycare AddStaff")
        .doc(ID)
        .get();

    if (docSnapshot.exists) {
      var data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        Name.text = data['Staff Name'] ?? '';
        // Address.text = data['Address'] ?? '';
        Qualification.text = data['Qualification'] ?? '';
        // Experience.text = data['experiance'] ?? '';
        PhoneNumber.text = data['Phone'] ?? '';
        // whatsappnumber.text = data['whatsappNumber'] ?? '';

      });
    }
    print("sharedPreference Data get");
  }

  final formkey = GlobalKey<FormState>();
  var Name = TextEditingController();
  var Address = TextEditingController();

  var Qualification = TextEditingController();
  var Experience = TextEditingController();
  var PhoneNumber = TextEditingController();
  var whatsappnumber = TextEditingController();

  Future<dynamic> TrEdit() async {
    await FirebaseFirestore.instance
        .collection("Daycare AddStaff")
        .doc(ID)
        .update({
      "Staff Name": Name.text,
      // "address": Address.text,
      "Qualification": Qualification.text,
      // "experiance": Experience.text,
      "Phone": PhoneNumber.text,
      // "whatsappNumber": whatsappnumber.text,
    });
    print('Edit successfully');

    setState(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TeacherProfile()));
    });
  }

  final picker = ImagePicker();

  File? _imageFile;

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Icon(Icons.arrow_back),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
                        ),
                        // Container(
                        //   height: 79,
                        //   width: 50,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(25),
                        //       image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: _imageFile != null
                        //             ? FileImage(_imageFile!)
                        //             : const AssetImage('assets/teacher.png')
                        //                 as ImageProvider<Object>,
                        //       )),
                        // ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 180, top: 15),
                  child: Text(
                    "Edit",
                    style: GoogleFonts.ubuntu(
                        color: Color(0xFFC24A6B), fontSize: 20),
                  ),
                ),
                // Positioned(
                //     top: 50,
                //     left: 75,
                //     child: IconButton(
                //       onPressed: () async {
                //         await getImage();
                //       },
                //       icon: Icon(Icons.camera_alt_outlined),
                //     )),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .12),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: Name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty Name !";
                          }
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Address"),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextFormField(
                    //     controller: Address,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "Empty Address !";
                    //       }
                    //     },
                    //     maxLines: 2,
                    //     minLines: 2,
                    //     decoration: InputDecoration(
                    //         border: const OutlineInputBorder(),
                    //         filled: true,
                    //         fillColor: Colors.white),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0, top: 10),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Daycare Name"),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextFormField(
                    //     controller: DaycareName,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "Empty Daycare Name !";
                    //       }
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(),
                    //         filled: true,
                    //         fillColor: Colors.white),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Qualification "),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: Qualification,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty Qualification !";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Experience"),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextFormField(
                    //     controller: Experience,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "Empty Experience !";
                    //       }
                    //     },
                    //     maxLines: 2,
                    //     minLines: 2,
                    //     decoration: InputDecoration(
                    //         border: const OutlineInputBorder(),
                    //         filled: true,
                    //         fillColor: Colors.white),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phone Number"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: PhoneNumber,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty Phone Number !";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0, top: 10),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Whatsapp Number"),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.number,
                    //     controller: whatsappnumber,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "Empty Whatsapp Number !";
                    //       }
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(),
                    //         filled: true,
                    //         fillColor: Colors.white),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                TrEdit();
                              });
                            }
                          },
                          child: Text(
                            "Update",
                            style: GoogleFonts.inriaSerif(
                                color: Colors.white, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .035,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
