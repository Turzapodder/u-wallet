import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Main_Pages/Paymnet_contacts.dart';
import 'package:uwallet/Main_Pages/add_money_method.dart';
import 'package:uwallet/Main_Pages/bill_pay.dart';
import 'package:uwallet/contacts.dart';

import '../utils/Shared_preferences.dart';

class dashboard_container extends StatelessWidget {


   dashboard_container({
    super.key,
  });

  final String? sharedValue = SharedPreferenceHelper().getValue();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(sharedValue=="Adult"?Icons.compare_arrows:FontAwesome.bolt, color: Colors.white,),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          sharedValue=="Adult"?Payment_contact():PayBillPage()));
                },
              ),
              Text(sharedValue=="Adult"?"Transfer":"Pay Bills", style: TextStyle(fontSize: 12, color: Colors.white),),
            ],
          ),
          Container(
            height: 40, // Set the desired height for the VerticalDivider container
            child: VerticalDivider(
              color: Colors.white60,
              thickness: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(sharedValue=="Adult"?MaterialCommunityIcons.wallet_outline:Icons.request_page_rounded, color: Colors.white, size: 30,),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          sharedValue=="Adult"?AddMoneyMethod():ContactsPage()));
                },
              ),
              Text(sharedValue=="Adult"?"Add Money":"Request Money",style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
          Container(
            height: 40, // Set the desired height for the VerticalDivider container
            child: VerticalDivider(
              color: Colors.white60,
              thickness: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.history_outlined, color: Colors.white, size: 30,),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              Text("History", style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
