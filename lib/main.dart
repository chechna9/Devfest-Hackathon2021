import 'package:brainsapp/Screens/Help_Camera.dart';
import 'package:brainsapp/Screens/Home.dart';
import 'package:brainsapp/Screens/Login.dart';
import 'package:brainsapp/Screens/SignIn.dart';
import 'dart:async';
import 'package:brainsapp/real_time.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/real_time': (context) => RealTime(
              cameras: cameras,
            ),
      },
      title: 'Text To Speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
