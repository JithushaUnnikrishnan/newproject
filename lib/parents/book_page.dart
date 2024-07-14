// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiny/parents/parent_dr.dart';
// import 'package:flutter/material.dart';
//
// class SuccessPage extends StatefulWidget {
//   const SuccessPage({super.key});
//
//   @override
//   State<SuccessPage> createState() => _SuccessPageState();
// }
//
// class _SuccessPageState extends State<SuccessPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         // title: InkWell(onTap: (){
//         //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ParentBooking()));
//         // },
//         //   child: Icon(
//         //     Icons.arrow_back,
//         //   ),
//         // ),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance.collection("drbooking").get(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: CircularProgressIndicator(
//               color: Color(0xFF93B4D1),
//             ));
//           }
//           if (snapshot.hasError) {
//             return Text("Error${snapshot.error}");
//           }
//           final bookingsuc = snapshot.data?.docs ?? [];
//           return ListView.builder(
//             itemCount: bookingsuc.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Column(
//                     children: [
//                       // Text(
//                       //   "All Done",
//                       //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     Text(
//                       //       "Booking Successful",
//                       //       style: TextStyle(
//                       //           color: Color.fromRGBO(147, 181, 210, 1),
//                       //           fontSize: 25,
//                       //           fontWeight: FontWeight.bold),
//                       //     ),
//                       //     Icon(
//                       //       Icons.check_circle_outline,
//                       //       color: Color.fromRGBO(147, 181, 210, 1),size: 40,
//                       //     ),
//                       //   ],
//                       // ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .010,
//                       ),
//                       Container(
//                         height: 210,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color.fromRGBO(174, 214, 236, 1),
//                             boxShadow: [
//                               BoxShadow(
//                                 offset: Offset(0, 1),
//                                 color: Colors.grey,
//                                 spreadRadius: 1,
//                                 blurRadius: 1,
//                               )
//                             ]),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text("Dr.Name: "),
//                                 Text(bookingsuc[index]["drname"]),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text("Phone No: "),
//                                 Text(bookingsuc[index]["Phone"]),
//                               ],
//                             ),
//                             Container(
//                               child: Column(
//                                 children: [
//                                   // Divider(
//                                   //   color: Colors.grey,
//                                   //   thickness: 1,
//                                   //   endIndent: 25,
//                                   //   indent: 25,
//                                   // ),
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         .020,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text("child Name: "),
//                                       Text(bookingsuc[index]["Name"]),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text("Age:"),
//                                       Text(bookingsuc[index]["Age"]),
//                                       Text(" year")
//                                     ],
//                                   ),
//                                   Text(bookingsuc[index]["date"]),
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         .02,
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         FirebaseFirestore.instance
//                                             .collection("drbooking")
//                                             .doc(bookingsuc[index].id)
//                                             .delete();
//                                       });
//                                     },
//                                     child: Text("Cancel"),
//                                     style: ElevatedButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor: Colors.red.shade700,
//                                         elevation: 3,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10))),
//                                   ),
//
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         .010,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  var ID;

  @override
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
        automaticallyImplyLeading: false,


        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("drbooking").where("Status",isEqualTo: 1).where("parent id",isEqualTo: ID).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF93B4D1),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: GoogleFonts.lato(fontSize: 18, color: Colors.red),
              ),
            );
          }
          final bookingsuc = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: bookingsuc.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFE9F5F9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Booking Successful",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF093B64),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 20,
                    ),
                    buildBookingDetailRow("Dr. Name:", bookingsuc[index]["drname"]),
                    buildBookingDetailRow("Phone No:", bookingsuc[index]["Phone"]),
                    buildBookingDetailRow("Child Name:", bookingsuc[index]["Name"]),
                    buildBookingDetailRow("Age:", "${bookingsuc[index]["Age"]} year"),
                    buildBookingDetailRow("Date:", bookingsuc[index]["date"]),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection("drbooking")
                              .doc(bookingsuc[index].id)
                              .delete();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), backgroundColor: Colors.red.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildBookingDetailRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF093B64),
            ),
          ),
          Text(
            detail,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
