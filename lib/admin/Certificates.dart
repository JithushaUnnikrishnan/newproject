import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Certificate extends StatefulWidget {
  const Certificate({super.key, required this. id});
  final id;


  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  // var ID;
  //
  // void initState() {
  //   super.initState();
  //   getData();
  // }
  //
  // Future<void> getData() async {
  //   SharedPreferences spref = await SharedPreferences.getInstance();
  //   setState(() {
  //     ID = spref.getString("id");
  //   });
  //   print("sharedPreference Data get");
  // }
  DocumentSnapshot?certi;
  Getfirebase() async {
    certi =
    await FirebaseFirestore.instance.collection("DoctorReg").doc(widget.id).get();
    print("done");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Getfirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ));
          }
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }

          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(48.0),

                  child:  Container(
                    width: 200,
                    height:500,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:NetworkImage(certi!["certificateUrl"]),
                        fit: BoxFit.fill,
                      ),
                    ),


              ),
            ),
          );
        },

      ),
    );
  }
}
