import 'package:flutter/material.dart';

class Demotext extends StatefulWidget {
  const Demotext({super.key});

  @override
  State<Demotext> createState() => _DemotextState();
}

class _DemotextState extends State<Demotext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Jithushaunnikrishnan')),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(100),
        color: const Color.fromARGB(255, 233, 228, 228),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("data",selectionColor: Colors.amber,),
            const SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10,),

            ElevatedButton(onPressed:(){}, child: const Text("done",selectionColor: Colors.blueGrey))
            
          ],
        ),
      ),
    );
  }
}
