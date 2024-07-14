
import 'package:tiny/parents/parent%20choosing%20daycare.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class ParentSignup extends StatefulWidget {
  const ParentSignup({super.key});

  @override
  State<ParentSignup> createState() => _ParentSignupState();
}

class _ParentSignupState extends State<ParentSignup> {

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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        Dateofbirth.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

// Define your regular expression for password validation
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
                controller: password,
                validator: (value) => _validatePassword(context, value),
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
              padding: const EdgeInsets.only(left: 20, right: 40),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Date of birth!";
                  }
                },
                controller: Dateofbirth,
                decoration: InputDecoration(
                  labelText: 'Date Of Birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: Icon(Icons.calendar_today,color: Colors.green.shade900,),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
                style: TextStyle(fontSize: 18.0),
                readOnly: true,
                onTap: () => _selectDate(context),
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
                      "Next",
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
                      color:Colors.green.shade900 ),
                ),
              ),
            ),

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
