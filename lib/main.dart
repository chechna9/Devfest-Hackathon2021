import 'package:brainsapp/Screens/Help_Camera.dart';
import 'package:brainsapp/Screens/Home.dart';
import 'package:brainsapp/Screens/Login.dart';
import 'package:brainsapp/Screens/SignIn.dart';
import 'package:brainsapp/Screens/Speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text To Speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

