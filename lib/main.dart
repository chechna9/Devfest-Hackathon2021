import 'package:brainsapp/Screens/Help_Camera.dart';
import 'package:brainsapp/Screens/Home.dart';
import 'package:brainsapp/Screens/Loading.dart';
import 'package:brainsapp/Screens/Login.dart';
import 'package:brainsapp/Screens/SignIn.dart';
import 'package:brainsapp/Screens/splash_screen.dart';
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
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/real_time': (context) => RealTime(
              cameras: cameras,
            ),
        '/home': (context) => Home(),
        '/camera': (context) => HelpCamera(
              cameras: cameras,
            ),
        '/signIn': (context) => Signin(),
        '/login': (context) => Login(),
        '/loading': (context) => Loading(),
      },
      title: 'Text To Speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
