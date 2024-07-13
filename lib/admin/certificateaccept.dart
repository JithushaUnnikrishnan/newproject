import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptCerti extends StatefulWidget {
  const AcceptCerti({super.key, required this. id});
  final id;

  @override
  State<AcceptCerti> createState() => _AcceptCertiState();
}

class _AcceptCertiState extends State<AcceptCerti> {
  DocumentSnapshot?certiAcRj;
  Getfirebase() async {
    certiAcRj =
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
                    image:NetworkImage(certiAcRj!["certificateUrl"]),
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
