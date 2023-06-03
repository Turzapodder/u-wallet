import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/Otp_screen.dart';

//import 'otp.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final String userPhoneKey = 'userPhoneKey';
  bool _isPhoneNumberRegistered = false;



  Future<void> saveUserPhone(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPhoneKey, userPhone);
  }


  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
  }

  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  Future<void> checkPhoneNumberRegistration() async {
    String phoneNumber = myController.text;

    setState(() {
      _isPhoneNumberRegistered = false;
    });

    if (phoneNumber.isNotEmpty) {
      bool isRegistered = await isPhoneNumberRegistered(phoneNumber);

      setState(() {
        _isPhoneNumberRegistered = isRegistered;
      });
    }
  }
  Future<bool> isPhoneNumberRegistered(String phoneNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return querySnapshot.docs.isNotEmpty;
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
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
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
                            width: 40,
                          ),
                          Text("Signup with Phone",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          'assets/images/Logo.png',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter your phone number to receive a pin code to sign up.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(

                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black12),
                                    borderRadius: BorderRadius.circular(40)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black12),
                                    borderRadius: BorderRadius.circular(40)),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    '+88',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: myController,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  saveUserPhone(myController.text);
                                  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                                  QuerySnapshot snapshot = await usersCollection.where('phoneNumber', isEqualTo: myController.text).get();
                                  if (snapshot.docs.isNotEmpty){
                                    showToast(userType);
                                  }
                                  else{
                                    await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber: '+88'+myController.text,
                                      verificationCompleted: (PhoneAuthCredential credential) {},
                                      verificationFailed: (FirebaseAuthException e) {},
                                      codeSent: (String verificationId, int? resendToken) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OtpPage(number: myController.text, verify: verificationId,)),
                                        );
                                      },
                                      codeAutoRetrievalTimeout: (String verificationId) {},
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(
                                      userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71)),
                                  shape:
                                  MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
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
  void showToast(String user) {
    Fluttertoast.showToast(
      msg: 'This Number already has been used, try from different number',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
      textColor: Colors.white,
    );
  }
}
