import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/daycare_staff.dart';
import 'package:tiny/daycare/tabbardaycare.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaycareStafadd extends StatefulWidget {
  const DaycareStafadd({super.key});

  @override
  State<DaycareStafadd> createState() => _DaycareStafaddState();
}

class _DaycareStafaddState extends State<DaycareStafadd> {
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

  final formkey = GlobalKey<FormState>();
  var staffname = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var qualification = TextEditingController();
  var password = TextEditingController();

  Future<dynamic> DayAddStaff() async {
    await FirebaseFirestore.instance.collection("Daycare AddStaff").add({
      "Staff Name": staffname.text,
      "Phone": phone.text,
      "Email": email.text,
      "Qualification": qualification.text,
      "Daycare id": id,
      "password": password.text,
      "path": "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",


    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DaycareStaff()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 116,
          backgroundColor: Colors.white,
          title: Center(child: Image.asset("assets/pregister.png")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 37),
            child: Column(
              children: [
                TextFormField(
                  controller: staffname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Staff Name !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Staff Name",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Phone",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
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
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Email",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty password !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "password",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextFormField(
                  controller: qualification,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Qualification !";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Qualification",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      DayAddStaff();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 250,
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.inriaSerif(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(
                          117,
                          10,
                          100,
                          1,
                        )),
                  ),
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
