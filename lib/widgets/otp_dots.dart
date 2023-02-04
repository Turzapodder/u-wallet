import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpDots extends StatelessWidget {
  const OtpDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
<<<<<<< HEAD
        height: 60,
        width: 60,
        child: TextFormField(

          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          decoration: InputDecoration(
            hintText: "0",
            hintStyle:
            TextStyle(color: Colors.black12),
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
=======
        height: 80,
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            ),
>>>>>>> master
          ],
        ),
      ),
    );
  }
}
