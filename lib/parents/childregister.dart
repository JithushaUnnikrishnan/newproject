import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChildRegister extends StatefulWidget {
  const ChildRegister({super.key});

  @override
  State<ChildRegister> createState() => _ChildRegisterState();
}

class _ChildRegisterState extends State<ChildRegister> {
  final formkey=GlobalKey<FormState>();
  var childName = TextEditingController();
  var phonenumber = TextEditingController();
  var password = TextEditingController();
  var bloodgroup = TextEditingController();
  var parentsoccupation = TextEditingController();
  var Dateofbirth = TextEditingController();
  Future<dynamic> ChildReg() async {
    await FirebaseFirestore.instance.collection("ChildRegister").add({
      "ChildName": childName.text,
      "PhoneNumber": phonenumber.text,
      "Password": password.text,
      "BloodGroup": bloodgroup.text,
      "ParentOccupation": parentsoccupation.text,
      "Dateofbirth": Dateofbirth.text
    });
    print('done');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PBottomButton()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black,
          toolbarHeight: 100,
          backgroundColor: Color.fromRGBO(56, 127, 142, 1),
          title: Column(
            children: [
              Text(
                "Little Kids",
                style: GoogleFonts.inriaSerif(fontSize: 40, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ],
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                    controller: childName,
                    validator: (value){
                      if (value!.isEmpty){
                        return "Empty Child Name !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Child Name",
                        labelStyle: GoogleFonts.inriaSerif(
                            fontSize: 20, color: Colors.grey))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                TextFormField(
                  controller: phonenumber,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Empty Phone Number !";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone Number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: GoogleFonts.inriaSerif(
                          fontSize: 20, color: Colors.grey)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                TextFormField(
                  controller: password,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Empty Password !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Password",
                      labelStyle: GoogleFonts.inriaSerif(
                          fontSize: 20, color: Colors.grey)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                TextFormField(
                  controller: Dateofbirth,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Empty DOB !";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Date Of birth"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                TextFormField(
                  controller: bloodgroup,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Empty Blood Group !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Blood Group",
                      labelStyle: GoogleFonts.inriaSerif(
                          fontSize: 20, color: Colors.grey)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                TextFormField(
                    controller: parentsoccupation,
                    validator: (value){
                      if (value!.isEmpty){
                        return "Empty Parent Occupation !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Parent's Occupation",
                        labelStyle: GoogleFonts.inriaSerif(
                            fontSize: 20, color: Colors.grey))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .045,
                ),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      ChildReg();
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .06,
                    width: MediaQuery.of(context).size.height * .1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: GoogleFonts.inriaSerif(
                          fontSize: 20, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
