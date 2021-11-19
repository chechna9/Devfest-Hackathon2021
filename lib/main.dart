import 'dart:async';
import 'package:brainsapp/real_time.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/real_time',
    routes: {
      '/real_time': (context) => RealTime(
            cameras: cameras,
          ),
    },
  ));
}
