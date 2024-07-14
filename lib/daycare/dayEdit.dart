import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/daycare_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'daybottombutn.dart';

class DaycareEdit extends StatefulWidget {
  const DaycareEdit({super.key});

  @override
  State<DaycareEdit> createState() => _DaycareEditState();
}

class _DaycareEditState extends State<DaycareEdit> {
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
        .collection("DaycareRegister")
        .doc(ID)
        .get();


    if (docSnapshot.exists) {
      var data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        preschoolname.text = data['Username'] ?? '';
        phone.text = data['Phone'] ?? '';
        PreschoolAddress.text = data['PreschoolAddress'] ?? '';

      });
    }
    print("sharedPreference Data get");
  }

  final formkey = GlobalKey<FormState>();
  var preschoolname = TextEditingController();
  var phone = TextEditingController();

  var PreschoolAddress = TextEditingController();

  Future<dynamic> daycedit() async {
    await FirebaseFirestore.instance
        .collection("DaycareRegister")
        .doc(ID)
        .update({
      "Username": preschoolname.text,
      "Phone": phone.text,
      "PreschoolAddress": PreschoolAddress.text
    });
    print('Edit successfully');
    setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DayBottomButton()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: formkey,
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.green.shade200,
          toolbarHeight: 122,
          elevation: 6,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Center(
            child: Text(
              "Edit",
              style: GoogleFonts.inriaSerif(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: preschoolname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty PreschoolName !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Name"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  controller: PreschoolAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Preschool Address !";
                    }
                  },
                  minLines: 2,
                  maxLines: 2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Address"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Phone !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Phone Number"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                ),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()){
                      daycedit();
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .06,
                    width: MediaQuery.of(context).size.width * .25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade900,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: Colors.grey)
                        ]),
                    child: Center(
                        child: Text("Update",
                            style: GoogleFonts.inriaSerif(
                                color: Colors.white, fontSize: 20))),
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
