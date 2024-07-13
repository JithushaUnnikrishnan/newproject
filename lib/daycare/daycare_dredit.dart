import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/doctor/dr_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'daycare_drviewpage.dart';

class daycareDoctorEdit extends StatefulWidget {
  const daycareDoctorEdit({super.key});

  @override
  State<daycareDoctorEdit> createState() => _daycareDoctorEditState();
}

class _daycareDoctorEditState extends State<daycareDoctorEdit> {
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
        .collection("DoctorReg")
        .doc(ID)
        .get();


    if (docSnapshot.exists) {
      var data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        Name.text = data['Username'] ?? '';
        qualification.text = data['qualification'] ?? '';
        specialization.text = data['specialization'] ?? '';
        homeaddress.text = data['homeaddress'] ?? '';
        officeaddress.text = data['officeaddress'] ?? '';
        experience.text = data['experience'] ?? '';
      });
    }
    print("sharedPreference Data get");
  }
  final formkey = GlobalKey<FormState>();
  var Name = TextEditingController();
  var qualification = TextEditingController();
  var specialization = TextEditingController();
  var homeaddress = TextEditingController();
  var officeaddress = TextEditingController();
  var experience = TextEditingController();

  Future<dynamic> drEditt() async {
    await FirebaseFirestore.instance.collection("DoctorReg").doc(ID).update({
      "Username": Name.text,
      "qualification": qualification.text,
      "specialization": specialization.text,
      "homeaddress": homeaddress.text,
      "officeaddress": officeaddress.text,
      "experience": experience.text,

    });
    print('Edit successfully');
    // setState(() {
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Drview()));
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text('Edit',
                    style: GoogleFonts.inriaSerif(
                        fontSize: 35, color: Colors.white))),
            toolbarHeight: MediaQuery.of(context).size.height * .15,
            backgroundColor: Color.fromRGBO(
              147,
              180,
              209,
              1,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text("Name"),
                    TextFormField(
                      controller: Name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Name !";
                        }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text("qualification"),
                    TextFormField(
                      controller: qualification,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Qualification !";
                        }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text("Specialization"),
                    TextFormField(
                      controller: specialization,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Specialization !";
                        }
                      },
                      minLines: 2,
                      maxLines: 2,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text("Home Address"),
                    TextFormField(
                      controller: homeaddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Home Address !";
                        }
                      },
                      minLines: 2,
                      maxLines: 2,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text("Office Address"),
                    TextFormField(
                      controller: officeaddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Office Address !";
                        }
                      },
                      minLines: 2,
                      maxLines: 2,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text("Experiance"),
                    TextFormField(
                      controller: experience,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Experience !";
                        }
                      },
                      minLines: 2,
                      maxLines: 2,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            // drEditt();
                          });
                        }
                      },
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue),
                          child: Center(
                              child: Text(
                                "Update",
                                style: GoogleFonts.inriaSerif(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                  ]),
            ),
          )),
    );
  }
}
