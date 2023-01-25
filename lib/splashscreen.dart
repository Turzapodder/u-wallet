import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uwallet/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
        builder: (_) => OnBoard(),
        ),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/Logo.png",
          )],
        ),
      ),
    );
  }
}
