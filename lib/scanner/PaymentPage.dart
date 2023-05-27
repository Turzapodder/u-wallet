
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'scanner.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scanner()
    );
  }
}
