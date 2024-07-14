// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiny/daycare/daybottombutn.dart';
// import 'package:tiny/daycare/daycare_food.dart';
// import 'package:tiny/daycare/daycare_home.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'food_edit.dart';
//
// class DaycareFoodview extends StatefulWidget {
//   const DaycareFoodview({super.key});
//
//   @override
//   State<DaycareFoodview> createState() => _DaycareFoodviewState();
// }
//
// class _DaycareFoodviewState extends State<DaycareFoodview> {
//   var Daycarename;
//
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     SharedPreferences spref = await SharedPreferences.getInstance();
//     setState(() {
//       Daycarename = spref.getString("name");
//     });
//     print("sharedPreference Data get");
//   }
//   void showDeleteDialog(BuildContext context, String docId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Deletion"),
//           content: Text("Are you sure you want to delete this  week menu?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("OK"),
//               onPressed: () {
//                 FirebaseFirestore.instance
//                     .collection("Daycarefoodadd")
//                     .doc(docId)
//                     .delete();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//
//           title: Text(
//             "Food",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color.fromRGBO(117, 10, 100, 1),
//           toolbarHeight: 100,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => DaycareFood()));
//           },
//           child: Text("Add"),
//         ),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection("Daycarefoodadd")
//               .where("Daycare Name", isEqualTo: Daycarename)
//               .snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                   child: CircularProgressIndicator(
//                 color: Color(0xFF750A64),
//               ));
//             }
//             if (snapshot.hasError) {
//               return Text("Error:${snapshot.error}");
//             }
//             final Food = snapshot.data?.docs ?? [];
//             return ListView.builder(
//               itemCount: Food.length,
//               itemBuilder: (
//                 context,
//                 index,
//               ) {
//                 return SingleChildScrollView(
//                   // color: Colors.grey.shade100,
//                   // height: 900,width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           Text(Food[index]["date"]),
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             FoodUpdate(id: Food[index].id)));
//                               },
//                               icon: Icon(Icons.edit)),
//                           IconButton(
//                               onPressed: () {
//                                 showDeleteDialog(context, Food[index].id);
//                               },
//                               icon: Icon(Icons.delete)),
//                         ],
//                       ),
//                       Text(
//                         "Monday",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sunrise,
//                           color: Colors.red.shade300,
//                         ),
//                         title: Text(Food[index]["MBreakFast"]),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sun_max,
//                           color: Colors.yellow.shade700,
//                         ),
//                         title: Text(Food[index]["MLunch"]),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sunset_fill,
//                           color: Colors.orangeAccent,
//                         ),
//                         title: Text(Food[index]["MSnack"]),
//                       ),
//                       Text(
//                         "Tuesday",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sunrise,
//                             color: Colors.red.shade300),
//                         title: Text(Food[index]["MBreakFast"]),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sun_max,
//                             color: Colors.yellow.shade700),
//                         title: Text(Food[index]["TuLunch"]),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sunset_fill,
//                           color: Colors.deepOrange,
//                         ),
//                         title: Text(Food[index]["TuSnack"]),
//                       ),
//                       Text(
//                         "Wednesday",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sunrise,
//                             color: Colors.red.shade300),
//                         title: Text(Food[index]["WBreakFast"]),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sun_max,
//                             color: Colors.yellow.shade700),
//                         title: Text(Food[index]["WLunch"]),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sunset_fill,
//                           color: Colors.deepOrange,
//                         ),
//                         title: Text(Food[index]["WSnack"]),
//                       ),
//                       Text(
//                         "Thursday",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sunrise,
//                             color: Colors.red.shade300),
//                         title: Text(Food[index]["ThBreakFast"]),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sun_max,
//                             color: Colors.yellow.shade700),
//                         title: Text(Food[index]["ThLunch"]),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sunset_fill,
//                           color: Colors.deepOrange,
//                         ),
//                         title: Text(Food[index]["ThSnack"]),
//                       ),
//                       Text(
//                         "Friday",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sunrise,
//                             color: Colors.red.shade300),
//                         title: Text(Food[index]["FBreakFast"]),
//                       ),
//                       ListTile(
//                         leading: Icon(CupertinoIcons.sun_max,
//                             color: Colors.yellow.shade700),
//                         title: Text(Food[index]["FLunch"]),
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           CupertinoIcons.sunset_fill,
//                           color: Colors.deepOrange,
//                         ),
//                         title: Text(Food[index]["FSnack"]),
//                       ),
//                       Divider(),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'daycare_food.dart';
import 'food_edit.dart';

class DaycareFoodview extends StatefulWidget {
  const DaycareFoodview({Key? key});

  @override
  State<DaycareFoodview> createState() => _DaycareFoodviewState();
}

class _DaycareFoodviewState extends State<DaycareFoodview> {
  String? daycareName;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      daycareName = spref.getString("name");
    });
    print("SharedPreference Data retrieved: $daycareName");
  }

  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this week's menu?"),
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

        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),elevation: 4,shadowColor: Colors.grey,
        title: Text(
          "Food Menu",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w900,

          ),
        ),
        backgroundColor: Colors.green.shade200,
        toolbarHeight: 100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DaycareFood()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green.shade200,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Daycarefoodadd")
            .where("Daycare Name", isEqualTo: daycareName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF750A64),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          final foodList = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            foodList[index]["date"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FoodUpdate(id: foodList[index].id),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDeleteDialog(context, foodList[index].id);
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text("Monday",style: TextStyle(fontWeight: FontWeight.w900),),

                      _buildMealTile("Breakfast", foodList[index]["MBreakFast"]),
                      _buildMealTile("Lunch", foodList[index]["MLunch"]),
                      _buildMealTile("Snack", foodList[index]["MSnack"]),
                      Divider(color: Colors.grey),
                      Text("Tuesday",style: TextStyle(fontWeight: FontWeight.w900),),

                      _buildMealTile("Breakfast", foodList[index]["MBreakFast"]),
                      _buildMealTile("Lunch", foodList[index]["TuLunch"]),
                      _buildMealTile("Snack", foodList[index]["TuSnack"]),
                      Divider(color: Colors.grey),
                      Text("Wednesday",style: TextStyle(fontWeight: FontWeight.w900),),
                      _buildMealTile("Breakfast", foodList[index]["WBreakFast"]),
                      _buildMealTile("Lunch", foodList[index]["WLunch"]),
                      _buildMealTile("Snack", foodList[index]["WSnack"]),
                      Divider(color: Colors.grey),
                      Text("Thursday",style: TextStyle(fontWeight: FontWeight.w900),),

                      _buildMealTile("Breakfast", foodList[index]["ThBreakFast"]),
                      _buildMealTile("Lunch", foodList[index]["ThLunch"]),
                      _buildMealTile("Snack", foodList[index]["ThSnack"]),
                      Divider(color: Colors.grey),
                      Text("Friday",style: TextStyle(fontWeight: FontWeight.w900),),

                      _buildMealTile("Breakfast", foodList[index]["FBreakFast"]),
                      _buildMealTile("Lunch", foodList[index]["FLunch"]),
                      _buildMealTile("Snack", foodList[index]["FSnack"]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMealTile(String mealType, String meal) {
    return ListTile(
      title: Text(
        "$mealType: $meal",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      leading: _getMealIcon(mealType),
    );
  }

  Icon _getMealIcon(String mealType) {
    switch (mealType) {
      case "Breakfast":
        return Icon(Icons.free_breakfast, color: Colors.orangeAccent);
      case "Lunch":
        return Icon(Icons.restaurant_menu, color: Colors.yellow.shade700);
      case "Snack":
        return Icon(Icons.local_dining, color: Colors.deepOrange);
      default:
        return Icon(Icons.restaurant);
    }
  }
}
