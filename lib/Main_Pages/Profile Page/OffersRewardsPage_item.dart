import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';

import 'OffersRewardsPage.dart';
import '../Transaction_page.dart';

class TransactionWidget extends StatelessWidget {
  final Expensee expense;
  const TransactionWidget({
    Key? key,
    required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 15,),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: expense.bg,
                ),
                child: Icon(FontAwesome.dollar,color: Colors.white,),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(expense.merchant_name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  Text(DateFormat('EEEE, MMM d, yyyy').format(expense.time).toString(),style: TextStyle(fontSize: 12,))
                ],
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(expense.amount,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17), textAlign: TextAlign.end,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
