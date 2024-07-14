// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiny/daycare/daycare_staff.dart';
// import 'package:tiny/daycare/tabbardaycare.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DaycareStafadd extends StatefulWidget {
//   const DaycareStafadd({super.key});
//
//   @override
//   State<DaycareStafadd> createState() => _DaycareStafaddState();
// }
//
// class _DaycareStafaddState extends State<DaycareStafadd> {
//   var id;
//   var daycare_name;
//
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences spref = await SharedPreferences.getInstance();
//     setState(() {
//       id = spref.getString("id");
//       daycare_name = spref.getString("name");
//     });
//     print("sharedPreference Data get");
//   }
//
//   final formkey = GlobalKey<FormState>();
//   var staffname = TextEditingController();
//   var phone = TextEditingController();
//   var email = TextEditingController();
//   var qualification = TextEditingController();
//   var password = TextEditingController();
//
//   Future<dynamic> DayAddStaff() async {
//     await FirebaseFirestore.instance.collection("Daycare AddStaff").add({
//       "Staff Name": staffname.text,
//       "Phone": phone.text,
//       "Email": email.text,
//       "Qualification": qualification.text,
//       "Daycare id": id,
//       "password": password.text,
//       "Daycare Name":daycare_name,
//       "path":
//           "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
//     });
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => DaycareStaff()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formkey,
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 116,
//           backgroundColor: Colors.white,
//           title: Center(child: Image.asset("assets/pregister.png")),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 37),
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: staffname,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Staff Name !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       labelText: "Staff Name",
//                       labelStyle: GoogleFonts.inriaSerif(
//                           color: Colors.grey, fontSize: 20)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: phone,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Phone !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       labelText: "Phone",
//                       labelStyle: GoogleFonts.inriaSerif(
//                           color: Colors.grey, fontSize: 20)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   controller: email,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Email !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       labelText: "Email",
//                       labelStyle: GoogleFonts.inriaSerif(
//                           color: Colors.grey, fontSize: 20)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   controller: password,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty password !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       labelText: "password",
//                       labelStyle: GoogleFonts.inriaSerif(
//                           color: Colors.grey, fontSize: 20)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                 ),
//                 TextFormField(
//                   controller: qualification,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Qualification !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       labelText: "Qualification",
//                       labelStyle: GoogleFonts.inriaSerif(
//                           color: Colors.grey, fontSize: 20)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.1,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     if (formkey.currentState!.validate()) {
//                       DayAddStaff();
//                     }
//                   },
//                   child: Container(
//                     height: 60,
//                     width: 250,
//                     child: Center(
//                       child: Text(
//                         "Submit",
//                         style: GoogleFonts.inriaSerif(
//                           color: Colors.white,
//                           fontSize: 40,
//                         ),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Color.fromRGBO(
//                           117,
//                           10,
//                           100,
//                           1,
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'daycare_staff.dart';

class DaycareStafadd extends StatefulWidget {
  const DaycareStafadd({Key? key}) : super(key: key);

  @override
  _DaycareStafaddState createState() => _DaycareStafaddState();
}

class _DaycareStafaddState extends State<DaycareStafadd> {
  late String id;
  late String daycareName;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      id = spref.getString("id") ?? "";
      daycareName = spref.getString("name") ?? "";
    });
    print("sharedPreference Data get");
  }

  final formKey = GlobalKey<FormState>();
  final staffNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final qualificationController = TextEditingController();
  final passwordController = TextEditingController();

  String? validatePhoneNumber(String value) {
    Pattern pattern = r'^[0-9]{10}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter valid phone number';
    }
    return null;
  }

  String? validateEmail(String value) {
    Pattern pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    }
    return null;
  }

  Future<void> addStaff() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection("DaycareAddStaff").add({
          "StaffName": staffNameController.text,
          ""
          "Phone": phoneController.text,
          "Email": emailController.text,
          "Qualification": qualificationController.text,
          "DaycareId": id,
          "Password": passwordController.text,
          "DaycareName": daycareName,
          "Path":
          "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DaycareStaff()),

        );
        print("data");
      } catch (e) {
        // Handle error
        print("Error adding staff: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add staff. Please try again later."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Center(child: Image.asset("assets/pregister.png")),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 37),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: staffNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Staff Name !";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Staff Name",
                  labelStyle: GoogleFonts.inriaSerif(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Phone !";
                  }
                  return validatePhoneNumber(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Phone",
                  labelStyle: GoogleFonts.inriaSerif(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Email !";
                  }
                  return validateEmail(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Email",
                  labelStyle: GoogleFonts.inriaSerif(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: passwordController,
                validator:(value) => _validatePassword(context, value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Password",
                  labelStyle: GoogleFonts.inriaSerif(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormField(
                controller: qualificationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Qualification !";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Qualification",
                  labelStyle: GoogleFonts.inriaSerif(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              InkWell(
                onTap: (){

                  setState(() {

                    addStaff();
                  });},
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade900
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.inriaSerif(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
