//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../doctor/login_doctor.dart';
// import 'draddpagebydaycare.dart';
//
// class DoctorSignup extends StatefulWidget {
//   const DoctorSignup({super.key});
//
//   @override
//   State<DoctorSignup> createState() => _DoctorSignupState();
// }
//
// class _DoctorSignupState extends State<DoctorSignup> {
//   var ID;
//
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences spref = await SharedPreferences.getInstance();
//     setState(() {
//       ID = spref.getString("id");
//     });
//     print("sharedPreference Data get");
//   }
//
//   final formkey = GlobalKey<FormState>();
//   var name = TextEditingController();
//   var password = TextEditingController();
//   var email = TextEditingController();
//   var qualification = TextEditingController();
//   var specialization = TextEditingController();
//   var homeaddress = TextEditingController();
//   var officeaddress = TextEditingController();
//   var experience = TextEditingController();
//   var phone = TextEditingController();
//
//   File? _certificate;
//
//   Future pickCertificate() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _certificate = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<String> uploadCertificate(File certificate) async {
//     Reference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('certificates/${DateTime.now().millisecondsSinceEpoch.toString()}');
//     UploadTask uploadTask = storageReference.putFile(certificate);
//     await uploadTask.whenComplete(() {});
//     String returnURL = await storageReference.getDownloadURL();
//     return returnURL;
//   }
//
//   Future<dynamic> Doctoreg() async {
//     String certificateUrl = '';
//     if (_certificate != null) {
//       certificateUrl = await uploadCertificate(_certificate!);
//     }
//     await FirebaseFirestore.instance.collection("DoctorReg").add({
//       "Username": name.text,
//       "password": password.text,
//       "email": email.text,
//       "qualification": qualification.text,
//       "specialization": specialization.text,
//       "homeaddress": homeaddress.text,
//       "officeaddress": officeaddress.text,
//       "experience": experience.text,
//       "Phone": phone.text,
//       "status": 0,
//       "Daycare_id":ID,
//       "path": "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
//       "certificateUrl": certificateUrl,
//     });
//     print('successfully');
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => DrAdd()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formkey,
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 100,
//           elevation: 10,
//           shadowColor: Colors.black,
//           title: Padding(
//             padding: const EdgeInsets.only(left: 100),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Image.asset("assets/logo.png"),
//               radius: 35,
//             ),
//           ),
//           backgroundColor: const Color.fromRGBO(56, 127, 142, 1),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: name,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty name !";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Name",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: email,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Email !";
//                     }
//                     if (!RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
//                         .hasMatch(value)) {
//                       return "Invalid Email Format!";
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Email",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   obscureText: true,
//                   controller: password,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Password !";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Password",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: phone,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Phone !";
//                     }
//                     if (!RegExp(r"^\d{10}$").hasMatch(value)) {
//                       return "Invalid Phone Number!";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Phone",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: qualification,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Qualification !";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Qualification",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: specialization,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Empty Specialization !';
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Specialization",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: homeaddress,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Home address !";
//                     }
//                     return null;
//                   },
//                   minLines: 2,
//                   maxLines: 2,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Home Address ",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: officeaddress,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Office Address !";
//                     }
//                     return null;
//                   },
//                   minLines: 2,
//                   maxLines: 2,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Office Address",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: experience,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Experience !";
//                     }
//                     return null;
//                   },
//                   minLines: 2,
//                   maxLines: 2,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Experience",
//                     labelStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextButton(
//                   onPressed: pickCertificate,
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text("Upload Certificate"),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0),
//                   child: TextButton(
//                     onPressed: () {
//                       if (formkey.currentState!.validate()) {
//                         Doctoreg();
//                       }
//                     },
//                     style: TextButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: const Text("Submit"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../doctor/login_doctor.dart';
import 'draddpagebydaycare.dart';

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({Key? key}) : super(key: key);

  @override
  _DoctorSignupState createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
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
    print("sharedPreference Data get");
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final qualificationController = TextEditingController();
  final specializationController = TextEditingController();
  final homeAddressController = TextEditingController();
  final officeAddressController = TextEditingController();
  final experienceController = TextEditingController();
  final phoneController = TextEditingController();

  File? _certificate;

  Future pickCertificate() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _certificate = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadCertificate(File certificate) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('certificates/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(certificate);
    await uploadTask.whenComplete(() {});
    String returnURL = await storageReference.getDownloadURL();
    return returnURL;
  }

  Future<dynamic> doctorReg() async {
    String certificateUrl = '';
    if (_certificate != null) {
      certificateUrl = await uploadCertificate(_certificate!);
    }
    await FirebaseFirestore.instance.collection("DoctorReg").add({
      "Username": nameController.text,
      "password": passwordController.text,
      "email": emailController.text,
      "qualification": qualificationController.text,
      "specialization": specializationController.text,
      "homeaddress": homeAddressController.text,
      "officeaddress": officeAddressController.text,
      "experience": experienceController.text,
      "Phone": phoneController.text,
      "status": 0,
      "Daycare_id": ID,
      "path":
      "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
      "certificateUrl": certificateUrl,
    });
    print('Successfully registered');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DrAdd()));
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
        title: const Text('Doctor Signup'),
        centerTitle: true,
        backgroundColor: Colors.green.shade200,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              buildTextFormField(
                controller: nameController,
                hintText: "Name",
                validatorMessage: "Please enter your name",
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: emailController,
                hintText: "Email",
                validatorMessage: "Please enter a valid email",
                keyboardType: TextInputType.emailAddress,
                validatorPattern:
                r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
                validatorPatternMessage: "Invalid email format",
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: passwordController,
                hintText: "Password",
                validatorMessage: "Please enter a password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: phoneController,
                hintText: "Phone",
                validatorMessage: "Please enter a valid phone number",
                keyboardType: TextInputType.phone,
                validatorPattern: r"^\d{10}$",
                validatorPatternMessage: "Invalid phone number",
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: qualificationController,
                hintText: "Qualification",
                validatorMessage: "Please enter your qualification",
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: specializationController,
                hintText: "Specialization",
                validatorMessage: "Please enter your specialization",
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: homeAddressController,
                hintText: "Home Address",
                validatorMessage: "Please enter your home address",
                minLines: 2,
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: officeAddressController,
                hintText: "Office Address",
                validatorMessage: "Please enter your office address",
                minLines: 2,
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              buildTextFormField(
                controller: experienceController,
                hintText: "Experience",
                validatorMessage: "Please enter your experience",
                minLines: 2,
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickCertificate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Upload Certificate",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_certificate != null)
                const Text(
                  'Certificate Selected',
                  style: TextStyle(color: Colors.green),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    doctorReg();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.green.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String validatorMessage,
    String? validatorPattern,
    String? validatorPatternMessage,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      minLines: minLines,
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorMessage;
        }
        if (validatorPattern != null &&
            !RegExp(validatorPattern).hasMatch(value)) {
          return validatorPatternMessage ?? "Invalid input format";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
