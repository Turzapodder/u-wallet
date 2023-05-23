import 'package:flutter/material.dart';

class CustomLikedNotifcation extends StatelessWidget {
  const CustomLikedNotifcation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 0),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0xFF105D38),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Icon(Icons.credit_score, color: Colors.white, size: 30,)
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "৳250 top up successfuly added",
                      style:  TextStyle(color: Color(0xFF2E3E5C), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text("Check your balance to ensure",
                    style:  TextStyle(color: Color(0xFF9FA5C0), fontSize: 12))
              ],
            ),
          ),
        ],
      ),
    );
  }
}