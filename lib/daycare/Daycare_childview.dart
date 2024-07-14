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
    childview = await FirebaseFirestore.instance
        .collection('ParentRegister')
        .doc(widget.id)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getfirebase(),
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
          appBar: AppBar(
            backgroundColor: Colors.green.shade200,
            toolbarHeight: 100,
            elevation: 5,
            shadowColor: Colors.grey,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          ),
          body: Stack(
            children: [
              Positioned(
                  top: 5,
                  left: 150,
                  child: Container(
                      height: 100,
                      width: 100,
                      child: ClipOval(
                        child: Image.network(childview!['path']),
                      ))),
              Positioned(
                top: 150,left: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.person),
                        Text(
                          'Child Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(childview!['Child name'],style: TextStyle(fontSize: 17)),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Icon(Icons.location_on),
                        Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(childview!['Address'],style: TextStyle(fontSize: 17)),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Icon(Icons.calendar_month),
                        Text(
                          'Date of birth',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(childview!['Date of birth'],style: TextStyle(fontSize: 17)),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Icon(Icons.work),
                        Text(
                          "Parent Name:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(childview!['Parent Name'],style: TextStyle(fontSize: 17),),
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
