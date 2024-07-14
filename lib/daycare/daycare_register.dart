import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'daycare_login.dart';

class DaycareRegister extends StatefulWidget {
  const DaycareRegister({Key? key}) : super(key: key);

  @override
  _DaycareRegisterState createState() => _DaycareRegisterState();
}

class _DaycareRegisterState extends State<DaycareRegister> {
  final formKey = GlobalKey<FormState>();
  final preschoolNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final preschoolAddressController = TextEditingController();
  File? _certificate;
  bool _isLoading = false;

  Future<void> pickCertificate() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _certificate = File(pickedFile.path); // Corrected assignment
      });
    }
  }

  Future<String> uploadCertificate(File certificate) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('certificates/${DateTime.now().millisecondsSinceEpoch.toString()}');
    UploadTask uploadTask = storageReference.putFile(certificate);
    await uploadTask.whenComplete(() {});
    String returnURL = await storageReference.getDownloadURL();
    return returnURL;
  }

  Future<void> daycareReg() async {
    setState(() {
      _isLoading = true;
    });

    String certificateUrl = '';
    if (_certificate != null) {
      certificateUrl = await uploadCertificate(_certificate!);
    }

    await FirebaseFirestore.instance.collection("DaycareRegister").add({
      "Username": preschoolNameController.text,
      "Phone": phoneController.text,
      "Email": emailController.text,
      "Password": passwordController.text,
      "PreschoolAddress": preschoolAddressController.text,
      "certificate": certificateUrl,
      "status": 0,
      "path":
      "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
    });

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DaycareLogin()));
  }

  String? validatePhone(String? value) {
    final phoneRegex = RegExp(r'^\d{10}$');
    if (value == null || value.isEmpty) {
      return "Phone number is required!";
    } else if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid 10-digit phone number!";
    }
    return null;
  }

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (value == null || value.isEmpty) {
      return "Email is required!";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address!";
    }
    return null;
  }
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  String? _validatePassword(BuildContext context, String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      } else if (!passwordRegExp.hasMatch(value)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character'),
          ),
        );
        return 'An error occurred while validating the password:';
      }
      return null;
    } catch (e) {
      // Display the error message using ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while validating the password: $e'),
        ),
      );
      return 'An unexpected error occurred';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 37),
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/pregister.png"))),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: preschoolNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preschool name is required!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Preschool Name",
                      labelStyle:
                      GoogleFonts.inriaSerif(color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  validator: validatePhone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Phone",
                      labelStyle:
                      GoogleFonts.inriaSerif(color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Email",
                      labelStyle:
                      GoogleFonts.inriaSerif(color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) => _validatePassword(context, value),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Password",
                      labelStyle:
                      GoogleFonts.inriaSerif(color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: preschoolAddressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preschool address is required!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Preschool Address",
                      labelStyle:
                      GoogleFonts.inriaSerif(color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                _isLoading
                    ? CircularProgressIndicator()
                    : TextButton(
                  onPressed: pickCertificate,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.green.shade900,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Upload Certificate"),
                ),
                if (_certificate != null)
                  Text(
                    'Certificate Selected',
                    style: TextStyle(color: Colors.green),
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      daycareReg();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[900]),
                    child: Center(
                      child: Text(
                        "Register",
                        style: GoogleFonts.inriaSerif(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(fontSize: 15)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaycareLogin(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),

    );
  }
}
