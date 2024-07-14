import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/penroll_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logo/logo_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EnrollChild extends StatefulWidget {
  const EnrollChild({super.key});

  @override
  State<EnrollChild> createState() => _EnrollChildState();
}

class _EnrollChildState extends State<EnrollChild> {
  PickedFile? _image;
  bool isLoading = false;

  Future<void> _getImage() async {
    setState(() {
      isLoading = true;
    });
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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
          isLoading = false;
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

  DocumentSnapshot? parentChildProfile;

  Future<void> getFirebaseData() async {
    parentChildProfile = await FirebaseFirestore.instance
        .collection("ParentRegister")
        .doc(ID)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFirebaseData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF0E6174),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            backgroundColor: Colors.green.shade200,
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: Text(
              'Enroll Child',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EnrollEdit()),
                  );
                },
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image == null
                                ? NetworkImage(parentChildProfile!["path"])
                                : FileImage(File(_image!.path)) as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _getImage,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC65264),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    buildProfileDetail('Child Name', parentChildProfile!["Child name"]),
                    buildProfileDetail('Address', parentChildProfile!["Address"]),
                    buildProfileDetail('Date of Birth', parentChildProfile!["Date of birth"]),
                    buildProfileDetail('Parent Name', parentChildProfile!["Parent Name"]),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), backgroundColor: Color(0xFFC65264),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text(
                          'Logout',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LogoPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFC65264),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            detail,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}
