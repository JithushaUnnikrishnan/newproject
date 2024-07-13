import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/healthrecordjeni.dart';
// import 'package:demo/babysitters/mychildren%20home%20daily%20helth%20buton.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Daily healthbt.dart';
import 'Mychildernphoto.dart';

class HealthView extends StatefulWidget {
  const HealthView({
    super.key,
  });

  @override
  State<HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  var Stid;
  var Id;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      Stid = spref.getString("Studentid");
      Id = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('healthrecord add')
          .where("StudentId", isEqualTo: Stid)
          .where("Teacherid", isEqualTo: Id)
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.purple,
          ));
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        final health = snapshot.data?.docs ?? [];
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
              title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherChildprofile()));
                  },
                  child: Icon(Icons.arrow_back)),
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Text("Health Record",
                    style: GoogleFonts.ubuntu(color: Color(0xFFC24A6B))),
              ),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HealthRecord()));
            },
            child: Text("ADD"),
          ),
          body: ListView.builder(
            itemCount: health.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 50, top: 20, right: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text("Date: "),
                            Text(
                              health[index]["date"],
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("healthrecord add")
                                    .doc(health[index].id)
                                    .delete();
                              });
                            },
                            icon: Icon(CupertinoIcons.delete))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Height",
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                            Text(
                              "Weight",
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                            Text(
                              "Growth Rate ",
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                            Text(
                              "Temperature",
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              health[index]["Height"],
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                            Text(
                              health[index]["weight"],
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                            Text(
                              health[index]["Growth Rate"],
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                            Text(
                              health[index]["Temperature"],
                              style: GoogleFonts.inriaSerif(
                                  fontSize: 20, height: 2),
                            ),
                          ],
                        ),
                      ],
                    ),
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
