import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
import 'package:uwallet/set_password.dart';
>>>>>>> master
import 'package:uwallet/widgets/otp_dots.dart';

//import 'otp.dart';

class OtpPage extends StatefulWidget {
  final String number;
  OtpPage({required this.number});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black12,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text("Verify Phone",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Enter the code sent to ',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: widget.number,
                      style: TextStyle(
                        color: Color(0xFFFFAE58),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Change phone Number?",
                  style: TextStyle(
                    color: Color(0xFFFFAE58),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(12),
=======
                  //borderRadius: BorderRadius.circular(12),
>>>>>>> master
                ),
                child: Column(
                  children: [
                    Padding(
<<<<<<< HEAD
                      padding: const EdgeInsets.symmetric(horizontal: 30),
=======
                      padding: const EdgeInsets.symmetric(horizontal: 10),
>>>>>>> master
                      child: Form(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OtpDots(),
                            OtpDots(),
                            OtpDots(),
                            OtpDots(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
<<<<<<< HEAD
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          /*Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Otp()),
                          );*/
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFFFAE58)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Send Code',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
=======
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordPage()));
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
>>>>>>> master
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
