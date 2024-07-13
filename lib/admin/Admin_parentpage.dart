import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminParent extends StatefulWidget {
  const AdminParent({super.key, required this.id});
  final String id;

  @override
  State<AdminParent> createState() => _AdminParentState();
}

class _AdminParentState extends State<AdminParent> {
  Future<DocumentSnapshot> Getfirebase() async {
    return await FirebaseFirestore.instance.collection('ParentRegister').doc(widget.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Color.fromRGBO(119, 164, 204, 1),
        toolbarHeight: 104,
        title: Padding(
          padding: const EdgeInsets.only(left: 55),
          child: FutureBuilder<DocumentSnapshot>(
            future: Getfirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: Color(0xFF0E6174),
                );
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                return Text(
                  data["Child name"],
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                );
              }
              return Text("No Data");
            },
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: Getfirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0E6174),
                ));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            padding: EdgeInsets.all(20),
            height: 550,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Color.fromRGBO(119, 164, 204, 1), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0, 2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipOval(
                    child: Image.network(
                      data["path"],
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Child Details",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.grey.shade300),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Name: ",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      data["Child name"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Place: ",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      data["Address"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Date of Birth: ",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      data["Date of birth"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Join Date: ",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      data["date"],
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
