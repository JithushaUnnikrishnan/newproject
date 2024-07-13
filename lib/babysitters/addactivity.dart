// import 'package:demo/babysitters/babysitter_activity.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:open_app_file/open_app_file.dart';
//
// class AddActivity extends StatefulWidget {
//   const AddActivity({super.key});
//
//   @override
//   State<AddActivity> createState() => _AddActivityState();
// }
//
// class _AddActivityState extends State<AddActivity> {
//   PlatformFile? file;
//   Future<void> picksinglefile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       file = result.files.first;
//       file == null ? false : OpenAppFile.open(file!.path.toString());
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       title: Padding(
//         padding: const EdgeInsets.only(left: 70),
//         child: Text("Add Activity",style: GoogleFonts.ubuntu( color: Color(0xFFC24A6B))),
//       ),
//
//         toolbarHeight: 104,
//       ),
//
//       body: Container(
//
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             children: [
//               SizedBox(height: 30,),
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: "Time",
//                     labelStyle: TextStyle(color:  Colors.grey,)
//                 ),
//               ),
//               SizedBox(height: 20,),
//               TextFormField(
//
//                 decoration: InputDecoration(suffixIcon: IconButton(onPressed: picksinglefile, icon: Icon(Icons.file_copy)),
//                   border: OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: "Image",
//                   labelStyle: TextStyle(color:  Colors.grey,)
//                 ),
//               ),
//               SizedBox(height: 30,),
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: "Note",
//                   labelStyle: TextStyle(color: Colors.grey)
//                 ),
//               ),
//               SizedBox(height: 50,),
//               GestureDetector(
//                 onTap: (){
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => TeacherActivity()));
//                 },
//                 child: Container(
//                   height: 48,width: 135,
//
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.4),
//                           spreadRadius: 2,
//                           blurRadius: 2,
//                           offset: Offset(0, 2))
//                     ],
//                     borderRadius: BorderRadius.circular(10),color: Colors.blue,
//                   ),
//                   child: Center(child: Text("Done",style: GoogleFonts.inriaSerif(color: Colors.white,fontSize: 20),)),
//                 ),
//               )
//             ],
//           ),
//         )
//       ),
//
//     );
//   }
// }
