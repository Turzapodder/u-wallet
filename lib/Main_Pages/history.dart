import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionListView extends StatelessWidget {
  final String phoneNumber;

  const TransactionListView({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Transactions')
          .where('Receiver_num', isEqualTo: phoneNumber)
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> transactions =
              snapshot.data!.docs;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              Map<String, dynamic>? transactionData =
              transactions[index].data();

              if (transactionData != null) {
                String oppositeName = phoneNumber ==
                    transactionData['Sender_num']
                    ? transactionData['Receiver_name']
                    : transactionData['Sender_name'];

                double amount = double.parse(transactionData['amount'] ?? '0');
                String formattedAmount =
                phoneNumber == transactionData['Sender_num']
                    ? '-${amount.toStringAsFixed(2)}'
                    : '+${amount.toStringAsFixed(2)}';

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(oppositeName),
                      Text(transactionData['created_at'].toString()),
                      Text(transactionData['Sender_num']),
                    ],
                  ),
                  trailing: Text(formattedAmount),
                );
              } else {
                return SizedBox();
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error loading transactions');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}


