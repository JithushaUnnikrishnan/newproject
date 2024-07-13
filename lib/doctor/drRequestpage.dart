import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appointmentdr.dart';

class DoctorRequest extends StatefulWidget {
  const DoctorRequest({super.key, required this. id});
  final id;

  @override
  State<DoctorRequest> createState() => _DoctorRequestState();
}

class _DoctorRequestState extends State<DoctorRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Requests',
                style:
                    GoogleFonts.inriaSerif(fontSize: 35, color: Colors.white))),
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        backgroundColor: Color.fromRGBO(
          147,
          180,
          209,
          1,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("drbooking")
            .where("Status", isEqualTo: 0).where("Doctor Id",isEqualTo:widget.id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.purple,
            ));
          }
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          final ChildReq = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: ChildReq.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Container(
                  height: 135,
                  width: 320,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          color: Colors.grey),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ChildReq[index]["Name"]),
                            Text(ChildReq[index]["date"]),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                               setState(() {
                                 FirebaseFirestore.instance
                                     .collection("drbooking")
                                     .doc(ChildReq[index].id)
                                     .update({"Status": 1});
                                 print("approved");
                               });
                              },
                              child: Text("Approve"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shadowColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  elevation: 3),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            ElevatedButton(
                              onPressed: () {
                               setState(() {
                                 FirebaseFirestore.instance
                                     .collection("drbooking")
                                     .doc(ChildReq[index].id)
                                     .update({"Status": 2});
                                 print("rejected");
                               });
                              },
                              child: Text('  Reject  '),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shadowColor: Colors.grey,
                                foregroundColor: Colors.white,
                                elevation: 3,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
