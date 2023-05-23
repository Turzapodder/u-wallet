import 'package:flutter/material.dart';
import 'package:uwallet/HomePage/home_dashbord.dart';
import 'package:uwallet/HomePage/notification_page.dart';
import 'package:uwallet/signup_phone.dart';
import 'package:uwallet/usertype.dart';

import 'HomePage/PaymentPage.dart';

class Welldone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Well Done!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Your profile is now being reviewed. You can expect it to finish in the next 24 hours",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset('assets/images/well_done.png'),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentPage()));
                        },
                        child: SizedBox(
                          width: 250,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xFFFFAE58),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PaymentPage ()),
                                      );
                                    },
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ]));
  }
}
