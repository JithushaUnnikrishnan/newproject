import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/bs_bottombutton.dart';
import 'package:tiny/babysitters/jeni_profiledaily.dart';
// import 'package:demo/babysitters/mychildren%20home%20daily%20helth%20buton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Daily healthbt.dart';

class TeacherChildprofile extends StatefulWidget {
  const TeacherChildprofile({super.key});

  @override
  State<TeacherChildprofile> createState() => _TeacherChildprofileState();
}

class _TeacherChildprofileState extends State<TeacherChildprofile> {
  var Daycarename;
 

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      Daycarename = spref.getString("Daycarename");
     
    });
    print("sharedPreference Data get");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomButton()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text("My Children",
              style: GoogleFonts.ubuntu(color: Color(0xFFC24A6B))),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("ParentRegister").where("Daycare name",isEqualTo:Daycarename ).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(
              color: Color(0xFF0E6174),
            ));
          }
          if (snapshot.hasError) {
            return Text("Error:${snapshot.error}");
          }
          final student = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: student.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Container(
                    height: MediaQuery.of(context).size.height * .09,
                    width: MediaQuery.of(context).size.width * .15,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(fit: BoxFit.fill,image: NetworkImage(student[index]["path"]))),
                    // child: Image(
                    //   image: NetworkImage(student[index]["path"]),
                    //   height: 92,
                    //   width: 60,
                    // ),
                  ),
                  title: Text(student[index]["Child name"]),
                  subtitle: Text(student[index]["Phone"]),
                  trailing: InkWell(
                    onTap: () async {
                      SharedPreferences data =
                          await SharedPreferences.getInstance();
                      data.setString('Studentid', student[index].id);

                      print("shared preference get");


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MychildrenHome(id:student[index].id)));
                    },
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.black45)
                          ]),
                      child: Center(
                          child: Text(
                        "View",
                        style: GoogleFonts.inriaSerif(
                            fontSize: 20, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(255, 252, 250, 1),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon:Icon(
      //       CupertinoIcons.home,color: Colors.black,),label: "Home" ),
      //     BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_crop_circle_fill,color: Colors.black,),label: "Profile"),
      //   ],
      // ),
    );
  }
}
