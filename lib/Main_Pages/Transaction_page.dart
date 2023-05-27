import 'package:flutter/material.dart';

import '../utils/Shared_preferences.dart';
import '../widgets/transaction_item.dart';

class TransactionPage extends StatelessWidget {

  final String? sharedValue = SharedPreferenceHelper().getValue();
  TransactionPage({Key? key}) : super(key: key);

  final List<Expense> items = [
    Expense('Starbucks Coffee', DateTime.now(), "-৳156.00", Colors.green),
    Expense('December Subscription', DateTime.now(), "-৳60.00", Colors.pinkAccent),
    Expense('Netflix Subscription', DateTime.now(), "-৳87.00", Colors.black),
    Expense('Starbucks Coffee', DateTime.now(), "-৳156.00", Colors.lightGreenAccent),
    Expense('Starbucks Coffee', DateTime.now(), "-৳156.00", Colors.green),
    Expense('December Subscription', DateTime.now(), "-৳60.00", Colors.pinkAccent),
    Expense('Netflix Subscription', DateTime.now(), "-৳87.00", Colors.black),
    Expense('Starbucks Coffee', DateTime.now(), "-৳156.00", Colors.lightGreenAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
        title: Text(
          'Transactions',
          style: TextStyle(fontFamily: "Titillium Web", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 15),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20,right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expenses",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionWidget(expense: items[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
