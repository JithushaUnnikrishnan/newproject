import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Certificates.dart';

class AdmindrRequest extends StatefulWidget {
  const AdmindrRequest({super.key});

  @override
  State<AdmindrRequest> createState() => _AdmindrRequestState();
}

class _AdmindrRequestState extends State<AdmindrRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(
            'Doctors',
            style: GoogleFonts.ubuntu(color: Color(0xFFC24A6B)),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("DoctorReg")
            .where("status", isEqualTo: 1)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ));
          }
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          final Admindr = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Admindr.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
// ListTile(
//   leading: Column(
//     children: [
//       CircleAvatar(
//         radius: 0,
//         backgroundImage:NetworkImage( Admindr[index]["path"],) ,
//       ),
//     ],
//   ),
// )
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .035,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Admindr[index]["Username"],
                            style: GoogleFonts.inriaSerif(fontSize: 20),
                          ),
                          Text(
                            Admindr[index]["specialization"],
                            style: GoogleFonts.inriaSerif(fontSize: 15),
                          ),
                          Text(
                            Admindr[index]["experience"],
                            style: GoogleFonts.inriaSerif(fontSize: 15),
                          ),

                          // Container(
                          //   width: 200,
                          //   height: 300,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey),
                          //     borderRadius: BorderRadius.circular(10),
                          //     image: DecorationImage(
                          //       image: NetworkImage(Admindr[index]["certificateUrl"]),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: MediaQuery.of(context).size.height*.01),
                          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,foregroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Certificate(id:Admindr[index].id
                                            )));
                              },
                              child: Text("View Certificate"))
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .03,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection("DoctorReg")
                                      .doc(Admindr[index].id)
                                      .delete();
                                });
                                // setState(() {
                                //   FirebaseFirestore.instance
                                //       .collection("DoctorReg")
                                //       .doc(Admindr[index].id)
                                //       .update({"Status": 3});
                                // });
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ],
                  ),

                  // Row(
                  //
                  //   children: [
                  //     SizedBox(height: MediaQuery.of(context).size.height*.1,width: MediaQuery.of(context).size.width*.035,),
                  //     Container(
                  //       height: 36,
                  //       width: 80,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Color.fromRGBO(
                  //             233,
                  //             23,
                  //             23,
                  //             1,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //                 offset: Offset(0, 3),
                  //                 spreadRadius: 2,
                  //                 blurRadius: 2,
                  //                 color: Colors.black45)
                  //           ]),
                  //
                  //       child: Center(
                  //           child: Text(
                  //             "Reject",
                  //             style: GoogleFonts.inriaSerif(
                  //                 fontSize: 20, color: Colors.white),
                  //           )),
                  //     ), SizedBox(
                  //       width: MediaQuery.of(context).size.width * .0150,
                  //     ),
                  //     Container(
                  //       height: 36,
                  //       width: 80,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.blue,
                  //           boxShadow: [
                  //             BoxShadow(
                  //                 offset: Offset(0, 3),
                  //                 spreadRadius: 2,
                  //                 blurRadius: 2,
                  //                 color: Colors.black45)
                  //           ]),
                  //       child: Center(
                  //           child: Text(
                  //             "Accept",
                  //             style: GoogleFonts.inriaSerif(
                  //                 fontSize: 20, color: Colors.white),
                  //           )),
                  //     )],),
                  Divider(
                    thickness: 2,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
