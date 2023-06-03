
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/Shared_preferences.dart';
import 'custom_buton.dart';

class CustomFollowNotifcation extends StatefulWidget {
  final List<DocumentSnapshot> invitations;
  const CustomFollowNotifcation({required this.invitations,Key? key}) : super(key: key);

  @override
  State<CustomFollowNotifcation> createState() =>
      _CustomFollowNotifcationState();
}

class _CustomFollowNotifcationState extends State<CustomFollowNotifcation> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: const AssetImage("assets/images/Avatar.png"),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ashikur Jaman Rakib",
              style:  TextStyle(color: Color(0xFF2E3E5C), fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Invited You to become Family",
              style: TextStyle(fontSize:12, color: Color(0xFF9FA5C0)),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: CustomButton(
              height: 28,
              color: follow == false ? sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71) : Color(0xFFF4F5F7),
              textColor: follow == false ? Colors.white : Color(0xFF2E3E5C),
              onTap: () {
                setState(() {
                  follow = !follow;
                });
              },
              text: "Accept",
            ),
          ),
        ),
      ],
    );
  }
}