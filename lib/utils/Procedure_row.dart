import 'package:flutter/material.dart';

class Procedure extends StatelessWidget {
  const Procedure({
    super.key,
    required this.text,
    required this.userType,
    required this.size,
  });

  final String userType;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
            borderRadius: BorderRadius.circular(
                15)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: Colors.black54,
          ),
        ),
      ),
    ]);
  }
}