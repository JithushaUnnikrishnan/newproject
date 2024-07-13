import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'daycare_activity.dart';
import 'daycare_home.dart';

class ActivityEdit extends StatefulWidget {
  const ActivityEdit({super.key, required this.id});

  final id;

  @override
  State<ActivityEdit> createState() => _ActivityEditState();
}

class _ActivityEditState extends State<ActivityEdit> {
  final formKey = GlobalKey<FormState>();

  var activityname = TextEditingController();
  final date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<dynamic> Activityed() async {
    await FirebaseFirestore.instance
        .collection("DaycareActivity")
        .doc(widget.id)
        .update({
      "Activity_name": activityname.text,
      'Time': time.format(context),
      'date': DateFormat('dd/MM/yyyy').format(date)
    });
    print('done');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DaycareActivity()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: formKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DaycareHome()));
                  },
                  child: Icon(Icons.arrow_back)),
              SizedBox(
                width: MediaQuery.of(context).size.width * .35,
              ),
              Text("Edit", style: GoogleFonts.ubuntu(color: Color(0xFFC24A6B))),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              TextFormField(
                controller: activityname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty activity name !";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Activity Name",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .51,
              ),
              InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Activityed();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, bottom: 10),
                    child: Container(
                        height: 53,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: Center(
                          child: Text('Update',
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
