import 'package:flutter/material.dart';
import 'package:uwallet/create_new_password.dart';
import 'package:uwallet/set_password.dart';
import 'package:uwallet/widgets/otp_dots.dart';

//import 'otp.dart';

class ForgotOtpPage extends StatefulWidget {
  final String number = "01871038150";


  @override
  _ForgotOtpPageState createState() => _ForgotOtpPageState();
}

class _ForgotOtpPageState extends State<ForgotOtpPage> {

  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();
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
                      text: 'A verification code was just sent to this number: ',
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
                height: 28,
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OtpDots(controller: otpController1),
                          OtpDots(controller: otpController2),
                          OtpDots(controller: otpController3),
                          OtpDots(controller: otpController4),
                          OtpDots(controller: otpController5),
                          OtpDots(controller: otpController6),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        print(otpController1.text+otpController2.text+otpController3.text+otpController4.text+otpController5.text+otpController6.text);
                        /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassPage()));*/
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFFFAE58),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Enter a New Password",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                              ]),
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
