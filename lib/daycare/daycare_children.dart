import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/Daycare_childview.dart';
import 'package:tiny/daycare/daybottombutn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaycareChildren extends StatefulWidget {
  const DaycareChildren({super.key});

  @override
  State<DaycareChildren> createState() => _DaycareChildrenState();
}

class _DaycareChildrenState extends State<DaycareChildren> {
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
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DayBottomButton()));
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Color.fromRGBO(117, 10, 100, 1),
          toolbarHeight: 122,
          elevation: 6,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Center(
            child: Text(
              " Children",
              style: GoogleFonts.inriaSerif(
                fontSize: 38,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('ParentRegister').where("Daycare name",isEqualTo:name).get(),
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: Color(0xFF750A64),
              ));
            }
            if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            }
            final child = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: child.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 5),
                  child: Card(

                    child: ListTile(
                        leading: Text(child[index]['Child name'],
                            style:
                            GoogleFonts.inriaSerif(fontSize: 20,
                            color: Colors.black)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DaycareChildview(id:child[index].id)));
                          },
                          child: Container(
                              height: 35,
                              width: 70,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        color: Colors.black45)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "View",
                                  style: GoogleFonts.inriaSerif(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ),
SizedBox(width: 15,),
                        IconButton(onPressed: (){
                          setState(() {
                            FirebaseFirestore.instance.collection("ParentRegister").doc(child[index].id).delete();
                          });
                        }, icon: Icon(CupertinoIcons.delete)),

                      ],
                    ),
                  ),
                ),);
              },

            );
          },

        )
    );
  }
}
