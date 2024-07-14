import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activityedit.dart';

class DaycareActivity extends StatefulWidget {
  const DaycareActivity({super.key});

  @override
  State<DaycareActivity> createState() => _DaycareActivityState();
}

class _DaycareActivityState extends State<DaycareActivity> {
  int _itemcount = 0;
  var daycareID;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      daycareID = spref.getString("id");
    });
    print("sharedPreference Data get");
  }
  void showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this Activity?"),
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
                    .collection("DaycareActivity")
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
          backgroundColor: Colors.green.shade200,
          toolbarHeight: 100,
          elevation: 6,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Text(
            "Activity",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w900
            ),
          ),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("DaycareActivity").where("Daycare id",isEqualTo: daycareID).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: Color(0xFF750A64),
              ));
            }
            if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            }
            final activity = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: activity.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Card(
                    color: Colors.red.shade50,
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActivityEdit(
                                              id: activity[index].id,
                                            )));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDeleteDialog(context, activity[index].id);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(' Activity Name :'),
                              Text(activity[index]['Activity_name']),
                            ],
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .030),
                          Text(activity[index]['Time']),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .030),
                          Text(activity[index]['date'])
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(backgroundColor: Colors.green.shade200,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EditCard()));
            setState(() {
              _itemcount++; // Increase item count on FAB press
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}







class EditCard extends StatefulWidget {
  const EditCard({super.key});

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  var daycareID;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      daycareID = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  final formkey = GlobalKey<FormState>();
  var activty = TextEditingController();
  String select = '';
  String dateselect = '';
  final date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<dynamic> addactivity() async {
    await FirebaseFirestore.instance.collection("DaycareActivity").add({
      "Activity_name": activty.text,
      'Time': time.format(context),
      'date': DateFormat('dd/MM/yyyy').format(date),
      "Daycare id":daycareID,
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DaycareActivity()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(

        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.green.shade200,
          elevation: 3,
          shadowColor: Colors.grey,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DaycareActivity()));
                  },
                  child: Icon(Icons.arrow_back)),
              SizedBox(
                width: 100,
              ),
              Text("Add activity",
                  style: GoogleFonts.ubuntu()),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              TextFormField(
                controller: activty,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty Activity!";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Activity Name",
                ),
              ),
              // SizedBox(height: 20,),
              // Row(
              //
              //   children: [
              //     Expanded(child: InputDecorator(decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Date"))),
              //     SizedBox(width: 16),
              //     Expanded(child: InputDecorator(decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Time"))),
              //
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      addactivity();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, bottom: 10),
                    child: Container(
                        height: 53,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade900),
                        child: Center(
                          child: Text('Save',
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
