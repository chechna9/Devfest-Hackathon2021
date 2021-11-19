import 'package:flutter/material.dart';
import 'routes/speechPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/speech',
      routes: {
        '/speech': (context)=> SpeechPage(),
      },
      title: 'Text To Speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeechPage(title: 'Text To Speech'),
    );
  }
}
