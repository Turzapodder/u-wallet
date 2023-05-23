import 'package:flutter/material.dart';
import 'dart:io';

class PreviewImagePage extends StatelessWidget {
  final String imagePath;

  const PreviewImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final File imageFile = File.fromUri(Uri.parse(imagePath));
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
