import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/daycare_children.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaycareChildview extends StatefulWidget {
  const DaycareChildview({super.key, required this.id});
  final id;

  @override
  State<DaycareChildview> createState() => _DaycareChildviewState();
}

class _DaycareChildviewState extends State<DaycareChildview> {
  DocumentSnapshot? childview;

  Getfirebase() async {
    childview = await FirebaseFirestore.instance.collection('ParentRegister').doc(widget.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  Getfirebase(),
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

       return Scaffold(
          body: Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 350),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DaycareChildren()));
                      },
                      child: Icon(Icons.arrow_back)),
                ),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF750A64),
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          color: Colors.black45)
                    ]),
              ),
              Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 160, top: 120),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1, 4),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  color: Colors.grey)
                            ]),
                        height: 100,
                        width: 100,
                        child: Image.network(childview!['path'])),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 250, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .051,
                        ),
                        Text(
                            'Child Name',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 43),
                      child: Text(childview!['Child name']),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .051,
                        ),
                        Text(
                          'Address',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 43),
                      child: Text(childview!['Address']),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .051,
                        ),
                        Text(
                          'Date of birth',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 43),
                      child: Text(childview!['Date of birth']),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.work),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .051,
                        ),
                        Text(
                          "Parent Name",
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 43),
                      child: Text(childview!['Parent Name']),
                    ),
                    Divider(),


                  ],
                ),
              )
            ],
          ),
        );
      },

    );
  }
}
