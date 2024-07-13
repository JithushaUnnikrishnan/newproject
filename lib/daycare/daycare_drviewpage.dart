import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'daycare_dredit.dart';

class Drview extends StatefulWidget {
  const Drview({super.key, required this.id});
  final String id;

  @override
  State<Drview> createState() => _DrviewState();
}

class _DrviewState extends State<Drview> {
  DocumentSnapshot? doct;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFirebase();
  }

  getFirebase() async {
    doct = await FirebaseFirestore.instance
        .collection("DoctorReg")
        .doc(widget.id)
        .get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (doct == null || !doct!.exists) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
        ),
        body: Center(child: Text("Doctor not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildInfoRow(Icons.email, doct!['email']),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            buildInfoRow(Icons.home, doct!['homeaddress']),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            buildInfoRow(CupertinoIcons.building_2_fill, doct!['officeaddress']),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            buildInfoRow(Icons.school_outlined, doct!['qualification']),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            buildInfoRow(Icons.calendar_month_rounded, doct!['experience']),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            buildInfoRow(Icons.local_hospital, doct!['specialization']),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String info) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: MediaQuery.of(context).size.width * .05),
        Text(info, style: GoogleFonts.inriaSerif(fontSize: 15)),
      ],
    );
  }
}
