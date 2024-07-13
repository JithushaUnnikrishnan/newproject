import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetWhere extends StatefulWidget {
  const GetWhere({Key? key}) : super(key: key);

  @override
  _GetWhereState createState() => _GetWhereState();
}

class _GetWhereState extends State<GetWhere> {
  late Stream<QuerySnapshot> userDataStream;

  @override
  void initState() {
    super.initState();
    getData();
    userDataStream = FirebaseFirestore.instance
        .collection('d6UdY5bj6FGoFt8VayY9')
        .where('daycare id', isEqualTo: ID)
        .snapshots();
  }

  var ID;
  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");
    });
    print("sharedPreference Data get");
  }

  @override
  Widget build(BuildContext context) {
    return


         Scaffold(
          appBar: AppBar(
            title: Text('GET'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: userDataStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No data found.'),
                  );
                }
                // Data is ready
                var userData = snapshot.data!.docs;
                // Accessing the first document in the list
                var document = userData.first;
                // Accessing the 'Name' field from the document
                var name = document['MLunch'];
                var pass = document["MSnack"];
                // Displaying the name
                return Center(
                  child: Column(
                    children: [Text('Name: $name'), Text("pass:$pass")],
                  ),
                );
              }
            },
          ),
        );


  }
}
