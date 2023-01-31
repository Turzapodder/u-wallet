import 'package:flutter/material.dart';
import 'package:uwallet/signup_phone.dart';
import 'package:uwallet/usertype.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/w1.PNG'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'A new way to pay anything more faster',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                          height: 50,
                        ),
                         InkWell(
                           onTap: (){
                             Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context) => MyPage()));
                           },
                           child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFFFFAE58),
                                borderRadius: BorderRadius.circular(90.0)),
                            child: Row(mainAxisSize: MainAxisSize.min, children: const [
                              Text(
                                  "Log In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ]),
                        ),
                         ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFFFAE58),
                                    width: 2.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Row(mainAxisSize: MainAxisSize.min, children: const [
                              Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}