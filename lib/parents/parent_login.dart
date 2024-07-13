import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent%20choosing%20daycare.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:tiny/parents/daycare enrool.dart';
import 'package:tiny/parents/searchdaycare.dart';
import 'package:tiny/parents/signup_parent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:tiny/parents/signup_parent.dart';

class ParentLogin extends StatefulWidget {
  const ParentLogin({super.key});

  @override
  State<ParentLogin> createState() => _ParentLoginState();
}

class _ParentLoginState extends State<ParentLogin> {
  final formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  String id = "";
  String Name = "";



  void ParentLog() async {
    final user = await FirebaseFirestore.instance
        .collection('ParentRegister')
        .where('Email', isEqualTo: email.text)
        .where('Password', isEqualTo: password.text)
        .get();
    if (user.docs.isNotEmpty) {
      id = user.docs[0].id;
      Name = user.docs[0]["Daycare name"];

      SharedPreferences data = await SharedPreferences.getInstance();
      data.setString('id', id);
      data.setString("Daycare name", Name);

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return PBottomButton();
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width * .9,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                  image: AssetImage('assets/output.png'),
                  fit: BoxFit.fill,
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Login",
                        style: GoogleFonts.rubikGlitch(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty email !";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.grey[50],
                        labelStyle:  TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Password !";
                        }
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.grey[50],
                          labelStyle:  TextStyle(color: Colors.grey)),
                    ),
                  ),

                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ParentForgot()));
                  //   },
                  //   child: const Row(
                  //     children: [
                  //       Expanded(
                  //           child: Align(
                  //         alignment: Alignment.bottomRight,
                  //         child: Text(
                  //           "Forgot password?",
                  //           style: TextStyle(),
                  //         ),
                  //       )),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ParentLog();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                        child:  Text(
                          "Login",
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 140),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParentSignup()));
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        mouseCursor:
                            MaterialStateProperty.all(SystemMouseCursors.basic),
                      ),
                      child: const Text(
                        "Create account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
