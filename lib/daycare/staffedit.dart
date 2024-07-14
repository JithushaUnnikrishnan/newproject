// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiny/daycare/tabbardaycare.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'daycare_staff.dart';
//
// class StaffEdit extends StatefulWidget {
//   const StaffEdit({super.key ,required this.id});
//
//   final id;
//
//   @override
//   State<StaffEdit> createState() => _StaffEditState();
// }
//
// class _StaffEditState extends State<StaffEdit> {
//   final formKey = GlobalKey<FormState>();
//
//   var staffname = TextEditingController();
//   var phone = TextEditingController();
//
//   var qualification = TextEditingController();
//
//   Future<dynamic> Editstaff() async {
//     await FirebaseFirestore.instance.collection("DaycareAddStaff").doc(
//         widget.id).update({
//       "Staff Name": staffname.text,
//       "Phone": phone.text,
//
//       "Qualification": qualification.text
//     });
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => DaycareStaff()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//      return Form(key: formKey,
//       child: Scaffold(appBar: AppBar(
//         toolbarHeight: 116,
//         backgroundColor: Colors.white,
//         title: Center(child: Image.asset("assets/pregister.png")),
//       ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 37),
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
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       labelText: "Staff Name",
//                       labelStyle: GoogleFonts.inriaSerif(color: Colors.grey,fontSize: 20)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: phone,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Phone !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       labelText: "Phone",
//                       labelStyle: GoogleFonts.inriaSerif(color: Colors.grey,fontSize: 20)),
//                 ),
//
//
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//                 TextFormField(
//                   controller: qualification,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Empty Qualification !";
//                     }
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//
//                       labelText: "Qualification",
//                       labelStyle: GoogleFonts.inriaSerif(color: Colors.grey,fontSize: 20)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
//                 InkWell(onTap: (){
//                   if (formKey.currentState!.validate()){
//                     Editstaff() ;}
//                 },
//                   child: Container(
//                     height: 50,width: 250,
//                     child: Center(
//                       child: Text("update",style: GoogleFonts.inriaSerif(color: Colors.white,fontSize: 20, ),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),color: Colors.green.shade900
//                     ),
//                   ),
//                 ),
//
//
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'daycare_staff.dart';

class StaffEdit extends StatefulWidget {
  final String id;

  const StaffEdit({Key? key, required this.id}) : super(key: key);

  @override
  State<StaffEdit> createState() => _StaffEditState();
}

class _StaffEditState extends State<StaffEdit> {
  final formKey = GlobalKey<FormState>();

  var staffname = TextEditingController();
  var phone = TextEditingController();
  var qualification = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStaffData();
  }

  void fetchStaffData() async {
    try {
      DocumentSnapshot staffSnapshot = await FirebaseFirestore.instance
          .collection("DaycareAddStaff")
          .doc(widget.id)
          .get();

      if (staffSnapshot.exists) {
        var data = staffSnapshot.data() as Map<String, dynamic>;
        setState(() {
          staffname.text = data['StaffName'] ?? '';
          phone.text = data['Phone'] ?? '';
          qualification.text = data['Qualification'] ?? '';
        });
      }
    } catch (e) {
      print("Error fetching staff details: $e");
    }
  }

  Future<void> updateStaff() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection("DaycareAddStaff")
            .doc(widget.id)
            .update({
          "StaffName": staffname.text,
          "Phone": phone.text,
          "Qualification": qualification.text,
        });

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DaycareStaff())); // Navigate back to previous screen
      } catch (e) {
        print("Error updating staff: $e");
        // Handle error if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 4,
        shadowColor: Colors.grey,
        title: Text('Edit Staff'),
        backgroundColor: Colors.green.shade200,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: staffname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Staff Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Staff Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Phone";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: qualification,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Qualification";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Qualification",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,foregroundColor: Colors.white),
                onPressed: (){setState(() {
                  updateStaff();
                });},
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
