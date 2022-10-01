import 'package:flutter/material.dart';
import 'package:studentform/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String path="";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:home(),


    );
  }
}
