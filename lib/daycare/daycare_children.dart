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

  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this child?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("ParentRegister")
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          backgroundColor: Colors.green.shade200,
          toolbarHeight: 100,
          elevation: 6,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Text(
            " Children",
            style: GoogleFonts.poppins(
              fontSize: 20,fontWeight: FontWeight.w900,

            ),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('ParentRegister')
              .where("Daycare_id", isEqualTo: ID)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Card(
                    child: ListTile(
                      leading: Text(child[index]['Child name'],
                          style: GoogleFonts.inriaSerif(
                              fontSize: 20, color: Colors.black,fontWeight: FontWeight.w600)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DaycareChildview(
                                          id: child[index].id)));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              child: Text(
                                "View",
                                style: GoogleFonts.inriaSerif(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                              onPressed: () {
                                showDeleteDialog(context, child[index].id);
                              },
                              icon: Icon(
                                CupertinoIcons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
