import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:uwallet/widgets/widget.dart';

import '../utils/Shared_preferences.dart';

class TransactionPage extends StatelessWidget {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final String? phone = SharedPreferenceHelper().getUserPhone();
  final String? name = SharedPreferenceHelper().getUserName();

  @override
  Widget build(BuildContext context) {
    print(phone);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: sharedValue == "Adult"
            ? Color(0xFFFFAE58)
            : Color(0xFF2ECC71),
        title: Text(
          'Transactions',
          style: TextStyle(
              fontFamily: "Titillium Web", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 15),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sent Money",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black38),
                ),
                Container(
                  height: 250,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Transactions')
                        .where('Sender_num', isEqualTo: phone)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Text('No transactions found.');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final transactionData =
                          snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                          final String senderNum =
                          transactionData['Sender_num'];
                          final String receiverName =
                          transactionData['Receiver_name'];
                          final String senderName =
                          transactionData['Sender_name'];
                          final DateTime createdAt =
                          (transactionData['created_at'] as Timestamp)
                              .toDate();
                          final double amount = transactionData['amount'];
                          final String formattedAmount = (phone ==
                              senderNum)
                              ? '- \৳${amount.toStringAsFixed(2)}'
                              : '+ \৳${amount.toStringAsFixed(2)}';

                          return TransactionWidget2(
                            merchantName: (phone == senderNum)
                                ? receiverName
                                : senderName,
                            time: createdAt ?? DateTime.now(),
                            amount: formattedAmount,
                            bg: Color(0xFFFFAE58),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Received Money",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black38),
                ),
                Container(
                  height: 250,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Transactions')
                        .where('Receiver_num', isEqualTo: phone)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Text('No transactions found.');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final transactionData =
                          snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                          final String senderNum =
                          transactionData['Sender_num'];
                          final String receiverName =
                          transactionData['Receiver_name'];
                          final String senderName =
                          transactionData['Sender_name'];
                          final DateTime createdAt =
                          (transactionData['created_at'] as Timestamp)
                              .toDate();
                          final double amount = transactionData['amount'];
                          final String formattedAmount = '+ \৳${amount.toStringAsFixed(2)}';

                          return TransactionWidget2(
                            merchantName: (phone == senderNum)
                                ? receiverName
                                : senderName,
                            time: createdAt ?? DateTime.now(),
                            amount: formattedAmount,
                            bg:Color(0xFF2ECC71),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
