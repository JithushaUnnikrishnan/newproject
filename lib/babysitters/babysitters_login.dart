import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/babysitter_home.dart';
import 'package:tiny/babysitters/babysitters_forgotpaswrd.dart';
import 'package:tiny/babysitters/babysitters_signup.dart';
import 'package:tiny/babysitters/bs_bottombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BabysitterLogin extends StatefulWidget {
  const BabysitterLogin({super.key});

  @override
  State<BabysitterLogin> createState() => _BabysitterLoginState();
}

class _BabysitterLoginState extends State<BabysitterLogin> {
  final formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  String id = "";
  String Daycare_id = "";

  void BabyLog() async {
    final user = await FirebaseFirestore.instance
        .collection('DaycareAddStaff')
        .where('Email', isEqualTo: email.text)
        .where('Password', isEqualTo: password.text)
        .get();
    if (user.docs.isNotEmpty) {
      id = user.docs[0].id;
      Daycare_id = user.docs[0]["DaycareId"];

      SharedPreferences data = await SharedPreferences.getInstance();
      data.setString('id', id);
      data.setString("Daycareid", Daycare_id);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return BottomButton();
        },
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Email and password invalid",
            style: TextStyle(color: Colors.red),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome, Babysitter!",
                      style: GoogleFonts.lato(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              color: Colors.green.shade900,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Empty Email !";
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email, color: Colors.green),
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Empty Password !";
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Password",
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock, color: Colors.green),
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                BabyLog();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.green.shade900,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
