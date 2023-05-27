import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.textLabel,
    required this.iconColor,
    required this.iconName,
  }) : super(key: key);


  final String textLabel;
  final Color iconColor;
  final IconData iconName;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Color(0xFFF6FAFD),
            borderRadius: BorderRadius.circular(15),
          ),
          child:
             Icon(iconName, color: iconColor, size: 25,),

        ),
        Text(textLabel, style: TextStyle(fontSize: 10,), textAlign: TextAlign.center,)
      ],
    );
  }
}