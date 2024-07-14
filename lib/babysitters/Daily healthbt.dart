import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/Mychildernphoto.dart';
import 'package:tiny/babysitters/dailyTaskview.dart';
import 'package:tiny/babysitters/healthrecordView.dart';
import 'package:tiny/babysitters/healthrecordjeni.dart';
import 'package:tiny/babysitters/jeni_profiledaily.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MychildrenHome extends StatefulWidget {
  const MychildrenHome({super.key, required this. id});
  final id;

  @override
  State<MychildrenHome> createState() => _MychildrenHomeState();
}

class _MychildrenHomeState extends State<MychildrenHome> {
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

  DocumentSnapshot? childprofile;

  Getfirebase() async {
    childprofile = await FirebaseFirestore.instance
        .collection("ParentRegister")
        .doc(widget.id)
        .get();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getfirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text("Error:${snapshot.error}");
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade200,
            elevation: 4,
            shadowColor: Colors.grey,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeacherChildprofile()));
                },
                icon: Icon(Icons.arrow_back)),
            toolbarHeight: 100,
            title:  Column(
              children: [
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 25,
                    //   backgroundImage:NetworkImage( childprofile!["path"],),
                    // ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(fit: BoxFit.fill,image: NetworkImage(childprofile!["path"]))),
                      // child: Image.network(childprofile!["path"]),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          childprofile!["Child name"],
                          style: GoogleFonts.inriaSerif(fontSize: 20,fontWeight: FontWeight.w900),
                        ),
                        // subtitle: Text(
                        //   childprofile!["gender"],
                        //   style: GoogleFonts.inriaSerif(fontSize: 20),
                        // ),
                      ),
                    )
                  ],
                ),
              ],
            ),


          ),

          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .18),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VideoListPage()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .14,
                      width: MediaQuery.of(context).size.width * .41,
                      child: Center(
                          child: Text(
                            'Daily Task',
                            style: GoogleFonts.inriaSerif(
                                color: Colors.white, fontSize: 19),
                          )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade800,
                              Colors.green.shade200,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 4),
                                spreadRadius: 2,
                                blurRadius: 4)
                          ]),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .17),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HealthView()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .14,
                      width: MediaQuery.of(context).size.width * .41,
                      child: Center(
                          child: Text(
                            'Health Record',
                            style: GoogleFonts.inriaSerif(
                                color: Colors.white, fontSize: 19),
                          )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade800,
                              Colors.green.shade200,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 4),
                                spreadRadius: 2,
                                blurRadius: 4)
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
