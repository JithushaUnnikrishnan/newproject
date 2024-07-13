import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherActivity extends StatefulWidget {
  const TeacherActivity({super.key});

  @override
  State<TeacherActivity> createState() => _TeacherActivityState();
}

List<Color> color = [
  Color(0XFFE9EAF4),
  Color(0XFFFFEEEA),
  Color(0XFFCDF2E0),
  Color(0XFFF4EEE1),
  Color(0XFFEBFAFE),
  Color(0XFFE9EAF4),
  Color(0XFFFFEEEA),
  Color(0XFFCDF2E0),
  Color(0XFFF4EEE1),
  Color(0XFFEBFAFE),
];
class _TeacherActivityState extends State<TeacherActivity> {
  var name;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name = spref.getString("name");
    });
    print("sharedPreference Data get");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          appBar: AppBar(

            backgroundColor: Color.fromRGBO(66, 135, 156, 1),
            toolbarHeight: 122,
            elevation: 6,
            shadowColor: Colors.grey,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [

              SizedBox(
                width: MediaQuery.of(context).size.width * .15,
              ),
              Text(
                "ACTIVITY",
                style: GoogleFonts.inriaSerif(
                    fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .05,
              ),
            ]),
          ),
          body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("DaycareActivity").where("Daycare Name",isEqualTo:name).get(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(
                  color: Color(0xFF0E6174),
                ));
              }
              if (snapshot.hasError) {
                return Text("Error:${snapshot.error}");
              }
              final Healthrecord = snapshot.data?.docs ?? [];
              return ListView.builder(
                itemCount:Healthrecord.length,
                itemBuilder: (context, index) {
                  return  Container(

                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .030,
                        ),
                        Container(
                          height: 82,
                          width: 316,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  color: Colors.black45)
                            ],
                            color: color[index],

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Healthrecord[index]["Activity_name"],
                                style: GoogleFonts.inriaSerif(fontSize: 20),
                              ),
                              Text(
                                Healthrecord[index]["Time"],
                                style: GoogleFonts.inriaSerif(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .050,
                        ),


                      ],
                    ),
                  );
                },

              );
            },

          ),
        );

  }
}
