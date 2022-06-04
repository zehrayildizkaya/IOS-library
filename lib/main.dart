import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_zehra/firebase_options.dart';
import 'package:library_zehra/login.dart';
import 'package:library_zehra/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KÜTÜPHANECİLİK',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MainPage(),
    );
  }
}
