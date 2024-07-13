import 'package:tiny/babysitters/babysitters_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BabysForgot extends StatefulWidget {
  const BabysForgot({super.key});

  @override
  State<BabysForgot> createState() => _BabysForgotState();
}

class _BabysForgotState extends State<BabysForgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90,left: 150),
              child: CircleAvatar(
                child: Image.asset(
                  'assets/ellips.png',
                ),
                backgroundColor: Colors.white,
                radius: 50,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.04,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("New Password",style: GoogleFonts.inriaSerif(fontSize: 20,),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.04,),
        Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Text("Confirm Password",style: GoogleFonts.inriaSerif(fontSize: 20,),),
    ),
    Padding(
    padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
    child: TextFormField(
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    ),
    ),
    ),
            SizedBox(height: MediaQuery.of(context).size.height*.1,),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BabysitterLogin()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.2)),
                  elevation: MaterialStateProperty.all(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Done",
                    style: GoogleFonts.inriaSerif(
                        fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),

      ]
        ),
      ),
    );
  }
}
