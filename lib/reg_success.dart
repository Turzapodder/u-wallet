import 'package:flutter/material.dart';
import 'package:uwallet/login_screen.dart';
import 'package:uwallet/signup_phone.dart';
import 'package:uwallet/usertype.dart';

class RegSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    Image.asset('assets/images/success.png'),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Welcome to UWallet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Voila! You have successfuly created your account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 100.0,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFFFAE58),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Continue",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ),
                    )
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