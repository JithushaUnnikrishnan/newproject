import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Parent_certificate extends StatefulWidget {
  const Parent_certificate({super.key, required this. id});
  final id;

  @override
  State<Parent_certificate> createState() => _Parent_certificateState();
}

class _Parent_certificateState extends State<Parent_certificate> {
  DocumentSnapshot? certview;

  Getfirebase() async {
    certview = await FirebaseFirestore.instance
        .collection('DoctorReg')
        .doc(widget.id)
        .get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Getfirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0E6174),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(certview!["certificateUrl"]))),
            );
          },

        ),
      ),
    );
  }
}
