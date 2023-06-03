import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpDots extends StatelessWidget {
  final TextEditingController controller;
  const OtpDots({required this.controller,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: TextFormField(
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
            return;
          }
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFAE58)),
              borderRadius: BorderRadius.circular(15)),
        ),
        textAlign: TextAlign.center,
        //style:Theme.of(context).textTheme.headlineMedium,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller,
      ),
    );
  }
}
