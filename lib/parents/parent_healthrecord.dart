import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent_addhealth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Parent_healthRecord extends StatefulWidget {
  const Parent_healthRecord({super.key});

  @override
  State<Parent_healthRecord> createState() => _Parent_healthRecordState();
}

class _Parent_healthRecordState extends State<Parent_healthRecord> {
  var ID;

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("healthrecord add").where("StudentId",isEqualTo:ID ).get(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF0E6174),
              ));
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        final health = snapshot.data?.docs ?? [];
    return    Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(66, 135, 156, 1),
            toolbarHeight: 122,
            elevation: 6,
            shadowColor: Colors.grey,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
            title:
            Text(
              "Health Record",
              style: GoogleFonts.inriaSerif(
                  fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold),
            ),


          ),
          body: ListView.builder(
            itemCount: health.length,
            itemBuilder: (context, index) {
              return
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 30, right: 50),
                child: Column(

                  children: [
                    Row(children: [Text("Date:"),Text(health[index]["date"]),IconButton(onPressed: (){setState(() {
                      FirebaseFirestore.instance
                          .collection("healthrecord add")
                          .doc(health[index].id)
                          .delete();
                    });}, icon: Icon(CupertinoIcons.delete))],),
                    Row(

                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Height",
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                            Text(
                              "Weight",
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                            Text(
                              "Growth Rate ",
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                            Text(
                              "Temperature",
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                        health[index]["Height"],
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                            Text(
                            health[index]["weight"],
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                            Text(
                            health[index]["Growth Rate"],
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                            Text(
              health[index]["Temperature"],
                              style: GoogleFonts.inriaSerif(fontSize: 20, height: 2),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => AddhealthRecord()));
                    //       },
                    //       child: Container(
                    //         child: Center(
                    //             child: Text(
                    //           "Add",
                    //           style: GoogleFonts.inriaSerif(
                    //               fontSize: 20, color: Colors.white),
                    //         )),
                    //         height: MediaQuery.of(context).size.height * .050,
                    //         width: MediaQuery.of(context).size.width * .25,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   offset: Offset(0, 4),
                    //                   spreadRadius: 1,
                    //                   blurRadius: 2,
                    //                   color: Colors.grey),
                    //             ],
                    //             color: Colors.blue),
                    //       ),
                    //     ),
                    //   ],
                    // )
                    Divider(),
                    
                  ],
                ),
              );
            },

          ),
        );
      },

    );
  }
}
