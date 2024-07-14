import 'package:flutter/material.dart';

class Certificateadminview extends StatefulWidget {
  const Certificateadminview({super.key, required this. path});
  final path;

  @override
  State<Certificateadminview> createState() => _CertificateadminviewState();
}

class _CertificateadminviewState extends State<Certificateadminview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
         child: Image(image: NetworkImage(widget.path)),
        ),
      ),
    );
  }
}
