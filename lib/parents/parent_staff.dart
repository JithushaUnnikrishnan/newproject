// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo/parents/parent_bottombuton.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ParentStaff extends StatefulWidget {
//   const ParentStaff({super.key});
//
//   @override
//   State<ParentStaff> createState() => _ParentStaffState();
// }
//
// class _ParentStaffState extends State<ParentStaff> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance.collection("babysiiterReg").get(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator(
//             color: Colors.purple,
//           ));
//         }
//         if (snapshot.hasError) {
//           return Text("Error${snapshot.error}");
//         }
//         final pstaff = snapshot.data?.docs ?? [];
//         return Scaffold(
//           body: Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: Stack(
//               children: [
//                 Container(
//                   height: 202,
//                   width: 415,
//                   color: Color.fromRGBO(238, 54, 74, 1),
//                   child: Row(
//                     children: [
//                       SizedBox(width: MediaQuery.of(context).size.width * .04),
//                       InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => PBottomButton()));
//                           },
//                           child: Icon(Icons.arrow_back)),
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Image.asset('assets/board.png'),
//                       Text('Teacher',
//                           style: GoogleFonts.irishGrover(
//                               fontSize: 50,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromRGBO(251, 149, 160, 1))),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                     top: 150,
//                     left: 1,
//                     right: 1,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 2,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(65),
//                           color: Colors.white),
//                       child: ListView.builder(
//                         itemCount: pstaff.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * .05),
//
//                               // SizedBox(height: MediaQuery.of(context).size.height * .09),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.black,
//                                       ),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: ListTile(
//                                       leading:
//                                           Image.network(pstaff[index]["path"]),
//                                       title: Text(pstaff[index]["UserName"],
//                                           style: GoogleFonts.inriaSerif(
//                                               fontSize: 15)),
//                                       subtitle: Text(
//                                         pstaff[index]["phonenumber"],
//                                         style: GoogleFonts.inriaSerif(
//                                             fontSize: 15),
//                                       ),
//                                       trailing: IconButton(
//                                         onPressed: () async {
//                                           final phonenumber =
//                                               pstaff[index]["phonenumber"];
//                                           final url = 'tel:$phonenumber';
//                                           if (await canLaunch(url)) {
//                                             await launch(url);
//                                           } else {
//                                             throw 'Could not launch $url';
//                                           }
//                                         },
//                                         icon: const Icon(
//                                           Icons.call,
//                                           color: Colors.green,
//                                           size: 30,
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class ParentStaff extends StatefulWidget {
  const ParentStaff({super.key});

  @override
  State<ParentStaff> createState() => _ParentStaffState();
}

class _ParentStaffState extends State<ParentStaff> {
  var id;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      id = spref.getString("id");
    });
    print("sharedPreference Data get");
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Daycare AddStaff").get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Color(0xFFEE364A),
          ));
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        final pstaff = snapshot.data?.docs ?? [];
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: 202,
                  width: 415,
                  color: Color.fromRGBO(238, 54, 74, 1),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * .04),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PBottomButton()));
                          },
                          child: Icon(Icons.arrow_back)),
                      SizedBox(width: MediaQuery.of(context).size.width * .02),
                      Image.asset('assets/board.png'),
                      Text('Teacher',
                          style: GoogleFonts.irishGrover(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(251, 149, 160, 1))),
                    ],
                  ),
                ),
                Positioned(
                    top: 150,
                    left: 1,
                    right: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(65),
                          color: Colors.white),
                      child: ListView.builder(
                        itemCount: pstaff.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05),

                              // SizedBox(height: MediaQuery.of(context).size.height * .09),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(

                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                      leading:Container(
                                        height: MediaQuery.of(context).size.height * .09,
                                          width: MediaQuery.of(context).size.width * .15,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(fit: BoxFit.fill,image: NetworkImage(pstaff[index]["path"]))),),
                                          // Image.network(pstaff[index]["path"]),
                                      title: Text(pstaff[index]["Staff Name"],
                                          style: GoogleFonts.inriaSerif(
                                              fontSize: 15)),
                                      subtitle: Text(
                                        pstaff[index]["Phone"],
                                        style: GoogleFonts.inriaSerif(
                                            fontSize: 15),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          final phonenumber =  pstaff[index]["Phone"] ;
                                          final url = 'tel:$phonenumber';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
