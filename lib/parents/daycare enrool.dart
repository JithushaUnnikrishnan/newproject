import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Enrolllparent extends StatefulWidget {
  const Enrolllparent({super.key});

  @override
  State<Enrolllparent> createState() => _EnrolllparentState();
}

class _EnrolllparentState extends State<Enrolllparent> {
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
    print("SharedPreference Data: $ID");
  }
  List<String> locationlist = ["male", "female", "other"];
  String? selectedvalue;
  final formkey = GlobalKey<FormState>();
  var parentname = TextEditingController();
  var phone = TextEditingController();
  var place = TextEditingController();
  var dateOfBirth = TextEditingController();
  var childName = TextEditingController();

  Future<dynamic> ChildReg() async {
    await FirebaseFirestore.instance.collection("ChildEnroll").add({
      "Parent Name": parentname.text,
      "Phone": phone.text,
      "Gender": selectedvalue,
      "Child name": childName.text,
      "Date of birth": dateOfBirth.text,
      "Place": place.text,
      "Daycare id":ID,
      "path": "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PBottomButton()));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dateOfBirth.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(

              child: Image.asset("assets/bb-removebg-preview.png")),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.7),
                  Colors.blue.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: parentname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Empty parent name!";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.person),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Empty Date of birth!";
                            }
                          },
                          controller: dateOfBirth,
                          decoration: InputDecoration(
                            labelText: 'Date Of Birth',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.calendar_today),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          style: TextStyle(fontSize: 18.0),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Empty Child Name!";
                            }
                          },
                          controller: childName,
                          decoration: InputDecoration(
                            labelText: 'Child Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.child_care),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Empty phone!";
                            }
                          },
                          controller: phone,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.phone),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Empty place!";
                            }
                          },
                          controller: place,
                          decoration: InputDecoration(
                            labelText: 'Place',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.location_on),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: double.infinity,
                          height: 63,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                            border: Border.all(),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            elevation: 0,
                            hint: const Text("Gender"),
                            underline: const SizedBox(),
                            value: selectedvalue,
                            items: locationlist.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newvalue) {
                              setState(() {
                                selectedvalue = newvalue;
                              });
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * .07),
                        GestureDetector(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              await ChildReg();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Enrollment Successful'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.withOpacity(0.7),
                                  Colors.blue.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Enroll',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
