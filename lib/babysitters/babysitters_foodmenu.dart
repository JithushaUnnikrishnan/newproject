import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BabysitterFoodmenu extends StatefulWidget {
  const BabysitterFoodmenu({super.key});

  @override
  State<BabysitterFoodmenu> createState() => _BabysitterFoodmenuState();
}

class _BabysitterFoodmenuState extends State<BabysitterFoodmenu> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title:  Row(
            children: [

              // InkWell(onTap: (){
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => PBottomButton()));
              // },
              //   child: Icon(
              //     Icons.arrow_back,
              //     color: Colors.white,
              //   ),
              // ),
              Image.asset('assets/food1.png'),
              Text('Food',
                  style: GoogleFonts.irishGrover(
                      fontSize: 60,
                      color: Color.fromRGBO(211, 134, 64, 1))),
            ],

          ),
          backgroundColor: Color.fromRGBO(254, 231, 127, 1),toolbarHeight: 150,),
        body:FutureBuilder(
          future: FirebaseFirestore.instance.collection("Daycarefoodadd").where("Daycare Name",isEqualTo: Daycarename).get(),
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: Color(0xFFE5C535),
              ));
            }
            if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            }
            final Food = snapshot.data?.docs ?? [];
            return  ListView.builder(
              itemCount: Food.length,
              itemBuilder: (context, index,) {

                return  SingleChildScrollView(
                  // color: Colors.grey.shade100,
                  // height: 900,width: double.infinity,
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 13,vertical: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Text(Food[index]["date"],style: TextStyle(fontWeight: FontWeight.w600),),

                            ],
                          ),

                          Text(
                            "Monday",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sunrise,
                              color: Colors.red.shade300,
                            ),
                            title: Row(
                              children: [
                                Text("Breakfast :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["MBreakFast"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sun_max,
                              color: Colors.yellow.shade700,
                            ),
                            title: Row(
                              children: [
                                Text("Lunch :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["MLunch"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sunset_fill,
                              color: Colors.orangeAccent,
                            ),
                            title: Row(
                              children: [
                                Text("Snack :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["MSnack"]),
                              ],
                            ),
                          ),
                          Divider(),

                          Text(
                            "Tuesday",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                            title: Row(
                              children: [
                                Text("Breakfast :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["MBreakFast"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading:
                            Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
                            title: Row(
                              children: [
                                Text("Lunch :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["TuLunch"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sunset_fill,
                              color: Colors.deepOrange,
                            ),
                            title: Row(
                              children: [
                                Text("Snack :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["TuSnack"]),
                              ],
                            ),
                          ),
                          Divider(),
                          Text(
                            "Wednesday",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                            title: Row(
                              children: [
                                Text("Breakfast :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["WBreakFast"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading:
                            Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
                            title: Row(
                              children: [
                                Text("Lunch :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["WLunch"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sunset_fill,
                              color: Colors.deepOrange,
                            ),
                            title: Row(
                              children: [
                                Text("Snack :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["WSnack"]),
                              ],
                            ),
                          ),
                          Divider(),

                          Text(
                            "Thursday",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                            title: Row(
                              children: [
                                Text("Breakfast :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["ThBreakFast"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading:
                            Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
                            title: Row(
                              children: [
                                Text("Lunch :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["ThLunch"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sunset_fill,
                              color: Colors.deepOrange,
                            ),
                            title: Row(
                              children: [
                                Text("Snack :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["ThSnack"]),
                              ],
                            ),
                          ),
                          Divider(),

                          Text(
                            "Friday",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                            title: Row(
                              children: [
                                Text("Breakfast :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["FBreakFast"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading:
                            Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
                            title: Row(
                              children: [
                                Text("Lunch :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["FLunch"]),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.sunset_fill,
                              color: Colors.deepOrange,
                            ),
                            title: Row(
                              children: [
                                Text("Snack :",style: TextStyle(fontWeight: FontWeight.w500),),

                                Text(Food[index]["FSnack"]),
                              ],
                            ),

                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                );
              },);
          },
        )
    );
  }
}
