import 'package:flutter/material.dart';

//import 'Offer_widget.dart';
import '../widgets/transaction_item.dart';


class TransactionPage extends StatelessWidget {
  TransactionPage({Key? key}) : super(key: key);

  final List<Expense> items = [
    Expense('20% off at Bookshop', DateTime.now(), "", Colors.green),
    Expense('Buy One Get One From Unimart', DateTime.now(), "", Colors.pinkAccent),
    Expense('Get 10% cashback at UIU canteen \non June 18 and 19', DateTime.now(), "", Colors.black),
    Expense('COMPUTER ClUB KIT PROMO CODE', DateTime.now(), "", Colors.lightGreenAccent),
    /*Expensee('Starbucks Coffee', DateTime.now(), "-৳156.00", Colors.green),
    Expensee('December Subscription', DateTime.now(), "-৳60.00", Colors.pinkAccent),
    Expensee('Netflix Subscription', DateTime.now(), "-৳87.00", Colors.black),
    Expensee('Starbucks Coffee', DateTime.now(), "-৳156.00", Colors.lightGreenAccent),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFAE58),
        title: Text(
          'Offers & Rewards',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              "Spend More, Save More \u{1F60A}", // Add the Unicode representation of the smile emoji
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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


