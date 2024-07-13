import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/daybottombutn.dart';
import 'package:tiny/daycare/daycare_food.dart';
import 'package:tiny/daycare/daycare_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food_edit.dart';

class DaycareFoodview extends StatefulWidget {
  const DaycareFoodview({super.key});

  @override
  State<DaycareFoodview> createState() => _DaycareFoodviewState();
}

class _DaycareFoodviewState extends State<DaycareFoodview> {
  var Daycarename;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      Daycarename = spref.getString("name");
    });
    print("sharedPreference Data get");
  }
  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this  week menu?"),
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
                    .collection("Daycarefoodadd")
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

          title: Text(
            "Food",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(117, 10, 100, 1),
          toolbarHeight: 100,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DaycareFood()));
          },
          child: Text("Add"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Daycarefoodadd")
              .where("Daycare Name", isEqualTo: Daycarename)
              .snapshots(),
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
            final Food = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: Food.length,
              itemBuilder: (
                context,
                index,
              ) {
                return SingleChildScrollView(
                  // color: Colors.grey.shade100,
                  // height: 900,width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(Food[index]["date"]),
                          IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodUpdate(id: Food[index].id)));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDeleteDialog(context, Food[index].id);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                      Text(
                        "Monday",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sunrise,
                          color: Colors.red.shade300,
                        ),
                        title: Text(Food[index]["MBreakFast"]),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sun_max,
                          color: Colors.yellow.shade700,
                        ),
                        title: Text(Food[index]["MLunch"]),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sunset_fill,
                          color: Colors.orangeAccent,
                        ),
                        title: Text(Food[index]["MSnack"]),
                      ),
                      Text(
                        "Tuesday",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise,
                            color: Colors.red.shade300),
                        title: Text(Food[index]["MBreakFast"]),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sun_max,
                            color: Colors.yellow.shade700),
                        title: Text(Food[index]["TuLunch"]),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sunset_fill,
                          color: Colors.deepOrange,
                        ),
                        title: Text(Food[index]["TuSnack"]),
                      ),
                      Text(
                        "Wednesday",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise,
                            color: Colors.red.shade300),
                        title: Text(Food[index]["WBreakFast"]),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sun_max,
                            color: Colors.yellow.shade700),
                        title: Text(Food[index]["WLunch"]),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sunset_fill,
                          color: Colors.deepOrange,
                        ),
                        title: Text(Food[index]["WSnack"]),
                      ),
                      Text(
                        "Thursday",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise,
                            color: Colors.red.shade300),
                        title: Text(Food[index]["ThBreakFast"]),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sun_max,
                            color: Colors.yellow.shade700),
                        title: Text(Food[index]["ThLunch"]),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sunset_fill,
                          color: Colors.deepOrange,
                        ),
                        title: Text(Food[index]["ThSnack"]),
                      ),
                      Text(
                        "Friday",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise,
                            color: Colors.red.shade300),
                        title: Text(Food[index]["FBreakFast"]),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sun_max,
                            color: Colors.yellow.shade700),
                        title: Text(Food[index]["FLunch"]),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.sunset_fill,
                          color: Colors.deepOrange,
                        ),
                        title: Text(Food[index]["FSnack"]),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
