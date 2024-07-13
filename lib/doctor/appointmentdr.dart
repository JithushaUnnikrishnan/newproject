import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drRequestpage.dart';

class DrAppointments extends StatefulWidget {
  const DrAppointments({super.key,  });



  @override
  State<DrAppointments> createState() => _DrAppointmentsState();
}

class _DrAppointmentsState extends State<DrAppointments> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments",style: GoogleFonts.poppins(fontSize: 25,color: Colors.white),),
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        backgroundColor: Color.fromRGBO(
          147,
          180,
          209,
          1,
        )
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("drbooking").where("Status",isEqualTo: 1).where("Doctor Id",isEqualTo: ID).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.purple,
            ));
          }
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          final Appointment = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Appointment.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                child: Card(
                  child: ListTile(
                    title: Text(
                      Appointment[index]["Name"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(Appointment[index]["Age"]),  Text(Appointment[index]["date"]),],
                    ),
                    trailing:
                        

                        TextButton(onPressed: (){
                          setState(() {
                            FirebaseFirestore.instance
                                .collection("drbooking")
                                .doc(Appointment[index].id)
                                .update({"Status": 3});
                          });
                        }, child: Text("Tap To Complete",))

                    
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
