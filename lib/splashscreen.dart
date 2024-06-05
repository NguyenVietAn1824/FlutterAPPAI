import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:od_app/home.dart';

class MySplash extends StatefulWidget {

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text('od_app',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color(0x00FFFF))),
      image: Image.asset('assets/img.png',
      ),
      backgroundColor: Colors.blueAccent,
      photoSize: 60,
      loaderColor: Color(0x004242),
    );
  }
}
