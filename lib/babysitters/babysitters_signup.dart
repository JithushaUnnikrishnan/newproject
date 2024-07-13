import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/babysitter_home.dart';
import 'package:tiny/babysitters/babysitters_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BabysitterSignup extends StatefulWidget {
  const BabysitterSignup({super.key});

  @override
  State<BabysitterSignup> createState() => _BabysitterSignupState();
}

class _BabysitterSignupState extends State<BabysitterSignup> {
  List<String> locationlist = ["male", "female", "other"];
  String? selectedvalue;
  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var address = TextEditingController();
  var qualification = TextEditingController();
  var Daycarename = TextEditingController();
  var experience = TextEditingController();
  var idproofnumber = TextEditingController();
  var phonenumber = TextEditingController();
  var gender = TextEditingController();
  var whatsapp = TextEditingController();
  String? Select;

  Future<dynamic> babysitterReg() async {
    await FirebaseFirestore.instance.collection("babysiiterReg").add({
      "UserName": name.text,
      "email": email.text,
      "password": password.text,
      "Address": address.text,
      "qualification": qualification.text,
      "daycarename": Select,
      "experiance": experience.text,
      "idproofnumber": idproofnumber.text,
      "phonenumber": phonenumber.text,
      "whatsappNumber": whatsapp.text,
      "gender": selectedvalue,
      "path": "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
    });
    print('done');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BabysitterLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          shadowColor: Colors.black,
          elevation: 10,
          title: Padding(
            padding: const EdgeInsets.only(right: 65),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/logo.png'),
                radius: 35,
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(113, 42, 168, 1),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Name!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Email!";
                    }
                    if (!RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                        .hasMatch(value)) {
                      return "Invalid Email Format!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Password!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: address,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Address!";
                    }
                    return null;
                  },
                  minLines: 3,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Address",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: qualification,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Qualification!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Qualification",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: experience,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Experience!";
                    }
                    return null;
                  },
                  minLines: 3,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Experience",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: idproofnumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Id proof Number!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Id Proof Number",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: phonenumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Phone Number!";
                    }
                    if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                      return "Invalid Phone Number!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Phone Number",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextFormField(
                  controller: whatsapp,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Whatsapp Number!";
                    }
                    if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                      return "Invalid Whatsapp Number!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Whatsapp Number",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: 360,
                      height: 69,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.transparent,
                          border: Border.all()),
                      child: DropdownButton<String>(
                          isExpanded: true,
                          elevation: 0,
                          // dropdownColor: Colors.grey.shade100,
                          hint: const Text("Gender"),
                          underline: const SizedBox(),
                          value: selectedvalue,
                          items: locationlist.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (newvalue) {
                            setState(() {
                              selectedvalue = newvalue;
                              print(selectedvalue);
                            });
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('DaycareRegister')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<String> tradeList = snapshot.data!.docs
                            .map((DocumentSnapshot document) =>
                            document['Username'].toString())
                            .toList();

                        return Container(
                          width: 361,
                          height: 69,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(10),
                            hint: Padding(
                              padding: const EdgeInsets.only(right: 110),
                              child: const Text("choose your Daycare "),
                            ),
                            value: Select,
                            // Set initial value if needed
                            onChanged: (String? newValue) {
                              setState(() {
                                Select = newValue!;
                                print(Select);
                              });
                            },
                            items: tradeList
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                                .toList(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
                width: 120,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (selectedvalue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            "select Gender",
                            style: TextStyle(color: Colors.red),
                          )));
                    }
                    if (Select == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            "select Daycare",
                            style: TextStyle(color: Colors.red),
                          )));
                    } else {
                      babysitterReg();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
