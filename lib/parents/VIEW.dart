import 'package:flutter/material.dart';

class View_cirtificate extends StatefulWidget {
  const View_cirtificate(this.certificate, {super.key});

  final certificate;

  @override
  State<View_cirtificate> createState() => _View_cirtificateState();
}

class _View_cirtificateState extends State<View_cirtificate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.certificate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.certificate))),
      ),
    );
  }
}
