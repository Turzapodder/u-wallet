import 'package:flutter/material.dart';

class NewWidget2 extends StatelessWidget {

  final String sm_title;
  final String bg_title;
  final Color bg_color;
  final Color ac_color;
  final String para;
  final String small;
  final Color txt;


  const NewWidget2({
    super.key,
    required this.sm_title,
    required this.bg_title,
    required this.bg_color,
    required this.ac_color,
    required this.para,
    required this.small,
    required this.txt,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bg_color,//Color(0xFF00373E),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sm_title,
              style: TextStyle(color: txt),
            ),
            SizedBox(height: 10,),
            Text(bg_title,
              style: TextStyle(color: txt, fontSize: 24),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(para ,style: TextStyle(color: txt,),),
                Transform.rotate(
                  angle: 45 * 3.1415927 / 180,
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: ac_color,//Color(0xFF4CD080),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text(small,style: TextStyle(color: Colors.white),))),
                ),
              ],)
          ],
        ),
      ),
    );
  }
}