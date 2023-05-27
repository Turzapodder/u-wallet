
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class QRCodeGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(),
    );
  }
}

