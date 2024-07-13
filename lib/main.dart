import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'admin/ad_home.dart';
import 'admin/tabbar.dart';
import 'daycare/DAycarefoodview.dart';
import 'daycare/daycare_register.dart';

import 'firebase_options.dart';
import 'jithu.dart';
import 'logo/logo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LogoPage());
  }
}
