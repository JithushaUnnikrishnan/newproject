import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent%20choosing%20daycare.dart';
import 'package:tiny/parents/parent_login.dart';
import 'package:tiny/parents/searchdaycare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentSignup extends StatefulWidget {
  const ParentSignup({super.key});

  @override
  State<ParentSignup> createState() => _ParentSignupState();
}

class _ParentSignupState extends State<ParentSignup> {
  // List<String> locationlist = ["male", "female", "other"];
  // String? selectedvalue;
  final formkey = GlobalKey<FormState>();
  var parentname = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var DaycareName = TextEditingController();
  var Dateofbirth = TextEditingController();
  var ChildName = TextEditingController();
  var Address = TextEditingController();
  // String? Select;
  String Select = '';
  String dateselect = '';
  final date = new DateTime.now();

  Future<dynamic> ParentReg() async {
    await FirebaseFirestore.instance.collection("ParentRegister").add({
      "Parent Name": parentname.text,
      "Phone": phone.text,
      "Email": email.text,
      "Password": password.text,
      "Daycare name": Select,
      "Child name": ChildName.text,
      "Date of birth": Dateofbirth.text,
      "Address": Address.text,
      "gender": null,
      ""
          'date': DateFormat('dd/MM/yyyy').format(date),
      "path":
          "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
    });
    print('done');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ParentLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: 250,
              height: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/pregister.png"))),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * .001,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                controller: ChildName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Child Name!";
                  }
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Child Name",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Phone!";
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return "Invalid Phone Number!";
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Phone",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Email!";
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return "Invalid Email!";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Email",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Password!";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Password",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                controller: Dateofbirth,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Date Of Birth!";
                  }
                },
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Date Of Birth",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                controller: parentname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Parent Name!";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Parent Name",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 20),
              child: TextFormField(
                minLines: 2,
                maxLines: 2,
                controller: Address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Address!";
                  }
                },
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Address",
                    labelStyle: GoogleFonts.inriaSerif(
                        color: Colors.grey, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 15),
            //       child: Container(
            //         width: 360,
            //         height: 69,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(6),
            //             color: Colors.transparent,
            //             border: Border.all()),
            //         child: DropdownButton<String>(
            //             isExpanded: true,
            //             elevation: 0,
            //             // dropdownColor: Colors.grey.shade100,
            //             hint: const Text("Gender"),
            //             underline: const SizedBox(),
            //             value: selectedvalue,
            //             items: locationlist.map((String value) {
            //               return DropdownMenuItem<String>(
            //                   value: value, child: Text(value));
            //             }).toList(),
            //             onChanged: (newvalue) {
            //               setState(() {
            //                 selectedvalue = newvalue;
            //                 print(selectedvalue);
            //               });
            //             },
            //             padding: const EdgeInsets.symmetric(horizontal: 10)),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     StreamBuilder<QuerySnapshot>(
            //       stream: FirebaseFirestore.instance
            //           .collection('DaycareRegister')
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const SizedBox();
            //         } else if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         } else {
            //           List<String> tradeList = snapshot.data!.docs
            //               .map((DocumentSnapshot document) =>
            //               document['Username'].toString())
            //               .toList();
            //
            //           return Container(
            //             width: 350,
            //             height: 60,
            //             decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.black54),
            //                 borderRadius: BorderRadius.circular(8)),
            //             child: DropdownButton<String>(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 20, vertical: 3),
            //               underline: const SizedBox(),
            //               borderRadius: BorderRadius.circular(10),
            //               hint: Padding(
            //                 padding: const EdgeInsets.only(right: 110),
            //                 child: const Text("choose your Daycare "),
            //               ),
            //               value: Select,
            //               // Set initial value if needed
            //               onChanged: (String? newValue) {
            //                 setState(() {
            //                   Select = newValue!;
            //                   print(Select);
            //                 });
            //               },
            //
            //               items: tradeList
            //                   .map<DropdownMenuItem<String>>(
            //                       (String value) => DropdownMenuItem<String>(
            //                     value: value,
            //                     child: Text(value),
            //                   ))
            //                   .toList(),
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     )
            //   ],
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.055,
            ),
            InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  {
                    // ParentReg();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        String name;
                        String phonenum;
                        String Email;
                        String Pass;

                        return ChoosingDaycare(
                          childname: ChildName.text,
                          phone: phone.text,
                          address: Address.text,
                          dob: Dateofbirth.text,
                          Email: email.text,
                          parentname: parentname.text,
                          pass: password.text,
                        );
                      },
                    ));
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Register",
                      style: GoogleFonts.inriaSerif(
                        height: 1,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(
                        14,
                        97,
                        116,
                        0.99,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Already have an account?", style: TextStyle(fontSize: 15)),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ParentLogin()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromRGBO(
                          14,
                          97,
                          116,
                          0.99,
                        ),
                        fontSize: 16),
                  ))
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
