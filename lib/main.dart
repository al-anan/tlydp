// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tlydp/screens/landing_screen.dart';
import 'package:tlydp/screens/my_duck_finds.dart';
import 'package:tlydp/screens/my_duck_makes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 140, 221, 240), 
          ),
      home: LandingScreen(),
    );
  }
}
