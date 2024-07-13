import 'package:tiny/admin/login_page.dart';
import 'package:tiny/logo/select_categoryfor%20reg.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common login.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/frontpage.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(

          children: [


            SizedBox(
              height: MediaQuery.of(context).size.height * .0250,
            ),
            Image.asset('assets/ellips.png'),
            Text('TinyTots Care', style: GoogleFonts.ingridDarling(fontSize: 45,fontWeight:FontWeight.bold),),
            SizedBox(
              height: MediaQuery.of(context).size.height * .20,
            ),
            Container(
              height: 55,width: 150,decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.5),
               borderRadius: BorderRadius.circular(10),boxShadow: [
                 BoxShadow(offset: Offset(0, 3),spreadRadius: 2,blurRadius: 2,color: Colors.black45)
            ]
            ),
              child: Center(child: GestureDetector(onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectCategoryreg()));
              },
                  child: Text('Start' ,style: GoogleFonts.fruktur(fontSize: 45,fontWeight:FontWeight.bold),))),
            )
          ],
        ),
      ),
    );
  }
}
