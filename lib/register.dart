import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("TinyTots Care")),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration:const InputDecoration(
                border: OutlineInputBorder(),labelText: 'Name'
              ),
            ),
            const SizedBox(
              height: 10,),
            TextFormField(
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),labelText: 'Address'
              ),
            ),
            const SizedBox(
              height: 10,),
            TextFormField(
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),labelText: 'Pin Code'
              ),
            ),
            const SizedBox(
              height: 10,),
            TextFormField(
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),labelText: 'Phone Number'
              ),
            ),
            const SizedBox(
              height: 30,),
            TextFormField(
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),labelText: 'WhatsApp'
              ),
            ),
            const SizedBox(
              height: 30,),
            TextFormField(
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),labelText: 'Email'
              ),
            ),


          ],
        ),
      ),
    );
  }
}
