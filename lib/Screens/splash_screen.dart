import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Timer(Duration(seconds: 5), () {
  //     Future.microtask(() async {
  //       await Duration(seconds: 5);

  //         Navigator.pushNamed(context, '/homeScreen');
  //         (route) => false;

  //     });
  //   });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5))
        .then((value) => Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF1597E5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("images/DF-logo-dark.png"),
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedTextKit(animatedTexts: [
              WavyAnimatedText('BrEYEn',
                  textStyle: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 40))
            ]),
          ],
        ),
      ),
    );
  }
}
