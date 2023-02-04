import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter/services.dart';
>>>>>>> master
import 'package:uwallet/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
>>>>>>> master
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily:'DMSans',

      ),
      home: SplashScreen(),
    );
  }
}

