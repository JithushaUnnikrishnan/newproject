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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(Food[index]["date"]),

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
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                        title: Text(Food[index]["MBreakFast"]),
                      ),
                      ListTile(
                        leading:
                        Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
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
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                        title: Text(Food[index]["WBreakFast"]),
                      ),
                      ListTile(
                        leading:
                        Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
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
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                        title: Text(Food[index]["ThBreakFast"]),
                      ),
                      ListTile(
                        leading:
                        Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
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
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.sunrise, color: Colors.red.shade300),
                        title: Text(Food[index]["FBreakFast"]),
                      ),
                      ListTile(
                        leading:
                        Icon(CupertinoIcons.sun_max, color: Colors.yellow.shade700),
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
              },);
          },
        )
    );
  }
}
