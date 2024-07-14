import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/babysitters/healthrecordView.dart';
// import 'package:demo/babysitters/mychildren%20home%20daily%20helth%20buton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthRecord extends StatefulWidget {
  const HealthRecord({super.key});

  @override
  State<HealthRecord> createState() => _HealthRecordState();
}

class _HealthRecordState extends State<HealthRecord> {
  var Stid;
  var ID;
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      Stid = spref.getString("Studentid");
      ID = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  final formkey = GlobalKey<FormState>();
  var height = TextEditingController();
  var weight = TextEditingController();
  var growthrate = TextEditingController();
  var temperature = TextEditingController();
  String dateselect = '';
  final date = new DateTime.now();
  Future<dynamic> HealthAdd() async {
    await FirebaseFirestore.instance.collection("healthrecord add").add({
      "Height": height.text,
      "weight": weight.text,
      "Growth Rate": growthrate.text,
      "Temperature": temperature.text,
      "StudentId": Stid,
      "Teacherid": ID,
      'date': DateFormat('dd/MM/yyyy').format(date),
    });

    print("done");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HealthView()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.green.shade200,
elevation: 4,shadowColor: Colors.grey,
toolbarHeight: 100,
          title: Text("Health Record",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w900)),
        ),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * .14),
                Text(
                  'Height',
                  style: GoogleFonts.inriaSerif(fontSize: 20),
                ),
                TextFormField(

                  controller: height,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Height !";
                    }
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .024,
                ),
                Text(
                  'Weight',
                  style: GoogleFonts.inriaSerif(fontSize: 20),
                ),
                TextFormField(
                  controller: weight,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty weight !";
                    }
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .024,
                ),
                Text(
                  'Growth Rate',
                  style: GoogleFonts.inriaSerif(fontSize: 20),
                ),
                TextFormField(
                  controller: growthrate,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Growth rate !";
                    }
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .024,
                ),
                Text(
                  'Temperature',
                  style: GoogleFonts.inriaSerif(fontSize: 20),
                ),
                TextFormField(
                  controller: temperature,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty Temperature !";
                    }
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .034,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              HealthAdd();
                            });

                          }
                        },
                        child: Text('Done',
                            style: GoogleFonts.inriaSerif(
                                fontSize: 15, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade900,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
