import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/daycare/DAycarefoodview.dart';
import 'package:tiny/daycare/daybottombutn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaycareFood extends StatefulWidget {
  const DaycareFood({super.key});

  @override
  State<DaycareFood> createState() => _DaycareFoodState();
}

class _DaycareFoodState extends State<DaycareFood> {
  var ID;
  var Name;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");
      Name = spref.getString("name");
    });
    print("sharedPreference Data get");
  }

  final formkey = GlobalKey<FormState>();
  var mbreakfast = TextEditingController();
  var mlunch = TextEditingController();
  var msnack = TextEditingController();
  var tubreakfast = TextEditingController();
  var tulunch = TextEditingController();
  var tusnack = TextEditingController();
  var wbreakfast = TextEditingController();
  var wlunch = TextEditingController();
  var wsnack = TextEditingController();
  var thbreakfast = TextEditingController();
  var thlunch = TextEditingController();
  var thsnack = TextEditingController();
  var fbreakfast = TextEditingController();
  var flunch = TextEditingController();
  var fsnack = TextEditingController();

  String dateselect = '';
  final date = new DateTime.now();

  Future<dynamic> DAycarefd() async {
    await FirebaseFirestore.instance.collection("Daycarefoodadd").add({
      "MBreakFast": mbreakfast.text,
      "MLunch": mlunch.text,
      "MSnack": msnack.text,
      "TuBreakFast": tubreakfast.text,
      "TuLunch": tulunch.text,
      "TuSnack": tusnack.text,
      "WBreakFast": wbreakfast.text,
      "WLunch": wlunch.text,
      "WSnack": wsnack.text,
      "ThBreakFast": thbreakfast.text,
      "ThLunch": thlunch.text,
      "ThSnack": thsnack.text,
      "FBreakFast": fbreakfast.text,
      "FLunch": flunch.text,
      "FSnack": fsnack.text,
      "daycare id": ID,
      "Daycare Name": Name,
      'date': DateFormat('dd/MM/yyyy').format(date)
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DaycareFoodview()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade200,
          toolbarHeight: 100,
          elevation: 6,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Text(
            "Food",
            style: GoogleFonts.poppins(
              fontSize: 20,fontWeight: FontWeight.w900
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monday',
                  style: GoogleFonts.inriaSerif(
                    fontSize: 20,fontWeight: FontWeight.w600
                  ),
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: mbreakfast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty breakfast !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "BreakFast",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: mlunch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Lunch !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Lunch",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: msnack,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Snack !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Snack",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Text(
                  'Tuesday',
                  style: GoogleFonts.inriaSerif(
                    fontSize: 20, fontWeight: FontWeight.w600,
                  ),
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: tubreakfast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Breakfast !";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "BreakFast",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: tulunch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Lunch !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Lunch",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: tusnack,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Snack !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Snack",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Text(
                  'Wednesday',
                  style: GoogleFonts.inriaSerif( fontSize: 20,fontWeight: FontWeight.w600,

                  ),
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: wbreakfast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Breakfast !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "BreakFast",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: wlunch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Lunch !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Lunch",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: wsnack,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Snack !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Snack",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Text(
                  'Thursday',
                  style: GoogleFonts.inriaSerif( fontSize: 20,fontWeight: FontWeight.w600,

                  ),
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: thbreakfast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Breakfast !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "BreakFast",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: thlunch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Lunch !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Lunch",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: thsnack,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Snack !";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Snack",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Text(
                  'Friday',
                  style: GoogleFonts.inriaSerif( fontSize: 20,fontWeight: FontWeight.w600,

                  ),
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: fbreakfast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Breakfast !";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "BreakFast",
                        labelStyle: GoogleFonts.inriaSerif(
                            color: Colors.grey, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: flunch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Lunch !";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Lunch",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Material(
                  elevation: 4,
                  shadowColor: Colors.black45,
                  child: TextFormField(
                    controller: fsnack,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Snack !";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Snack",
                      labelStyle: GoogleFonts.inriaSerif(
                          color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      print("done");
                      DAycarefd();
                    }
                  },
                  child: Text(
                    'Done',
                    style: GoogleFonts.inriaSerif(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
                )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
