import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/set_password.dart';
import 'package:uwallet/widgets/otp_dots.dart';

//import 'otp.dart';

class OtpPage extends StatefulWidget {
  final String number;
  final String verify;
  OtpPage({required this.number, required this.verify});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  final String userUidKey = 'userUidKey';

  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
  }

  Future<void> saveUserID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userUidKey, uid);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getUserType(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            String userType = snapshot.data ?? "";
            String code ="";
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
                                color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
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
                            color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Form(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                code=otpController1.text+otpController2.text+otpController3.text+otpController4.text+otpController5.text+otpController6.text;
                                try{
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verify, smsCode: code);
                                  UserCredential userCredential =await auth.signInWithCredential(credential);
                                  if (userCredential.user != null){saveUserID(userCredential.user!.uid);
                                  print(userCredential.user!.uid);}
                                  else{print('User credential is null');}
                                  Navigator.pushNamedAndRemoveUntil(context, 'passwordPage', (route) => false);
                                }
                                catch(e){
                                  showToast();
                                }
                                /**/
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 100.0,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                      color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                      borderRadius: BorderRadius.circular(
                                          25.0)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text("Continue",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
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
    );
  }
  void showToast() {
    Fluttertoast.showToast(
      msg: 'Wrong OTP! Please provide the correct OTP',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
  }