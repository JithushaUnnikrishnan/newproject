import 'package:tiny/parents/childregister.dart';
import 'package:tiny/parents/parent_bottombuton.dart';
import 'package:tiny/parents/parent_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchDaycare extends StatefulWidget {
  const SearchDaycare({super.key});

  @override
  State<SearchDaycare> createState() => _SearchDaycareState();
}

class _SearchDaycareState extends State<SearchDaycare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Adjust the height as needed
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Color.fromRGBO(164, 172, 173, 1)),
                prefixIcon: Icon(Icons.search,color: Color.fromRGBO(164, 172, 173, 1),),
                contentPadding: EdgeInsets.symmetric( horizontal: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade900), // Change focused border color
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Change enabled border color
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ),
body: Container(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          InkWell(onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChildRegister()));
          },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    spreadRadius: 3,
                    blurRadius: 2,
                    color: Colors.black45
                  )
                ],
                color: Color.fromRGBO(199, 231, 231, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Little Kids",style: GoogleFonts.inriaSerif(fontSize: 30),),
                  Icon(Icons.star,color: Colors.yellow,size: 50,),
                  Icon(Icons.star,color: Colors.yellow,size: 50),
                  Icon(Icons.star,color: Colors.yellow,size: 50)
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    spreadRadius: 3,
                    blurRadius: 2,
                    color: Colors.black45
                )
              ],
              color: Color.fromRGBO(199, 231, 231, 1),
            ),
            child: Row(

              children: [
                Padding(padding: EdgeInsets.only(left: 25)),
                Text("Sacred",style: GoogleFonts.inriaSerif(fontSize: 30),),
                SizedBox(width: MediaQuery.of(context).size.width * .13,),
                Icon(Icons.star,color: Colors.yellow,size: 50,),
                Icon(Icons.star,color: Colors.white,size: 50),
                Icon(Icons.star,color: Colors.white,size: 50)
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    spreadRadius: 3,
                    blurRadius: 2,
                    color: Colors.black45
                )
              ],
              color: Color.fromRGBO(199, 231, 231, 1),
            ),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 25)),
                Text("Tiny Kids",style: GoogleFonts.inriaSerif(fontSize: 30),),
                SizedBox(width: MediaQuery.of(context).size.width * .05,),
                Icon(Icons.star,color: Colors.yellow,size: 50,),
                Icon(Icons.star,color: Colors.yellow,size: 50),
                Icon(Icons.star,color: Colors.white,size: 50)
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.5,),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Text('Already have an account?',style: GoogleFonts.inriaSerif(fontSize: 15),),
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PBottomButton()));
                },
                    child: Text('Go to home',style: GoogleFonts.inriaSerif(fontSize: 15,color: Colors.blue),))
              ],
            ),
          )
        ],
      ),
    ),
  ),
),
    );
  }
}
