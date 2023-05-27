import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:uwallet/Main_Pages/bill_success.dart';

import '../utils/Shared_preferences.dart';

class PayBillCofrimPage extends StatelessWidget {
final String billerName;

PayBillCofrimPage(
    {required this.billerName,
      Key? key})
    : super(key: key);

  final String? sharedValue = SharedPreferenceHelper().getValue();

  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  OtpFieldController otpController = OtpFieldController();



  void _navigateToNextPage() {
    final String text1 = _textController1.text;
    final String text2 = _textController2.text;

    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(text1: text1, text2: text2),
      ),
    );*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Pay Bills',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay your bills right away",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "Your Current Balance:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2ECC71)),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Text(
                    "৳ 1500",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Biller Information",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sharedValue == "Adult"
                                  ? Color(0xFF2ECC71)
                                  : Color(0xFFFFAE58)),
                          child: Center(
                            child: Image.network(
                              "https://upload.wikimedia.org/wikipedia/en/thumb/6/6b/United_International_University_Monogram.svg/200px-United_International_University_Monogram.svg.png", fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(billerName,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    style: TextStyle(
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    controller: _textController1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter ID',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                          fontSize: 18,
                          color: Colors.black26),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _textController2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: "৳  Enter Amount",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                          fontSize: 18,
                          color: Colors.black26),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  Container(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Enter Pin"),
                        Center(
                          child: Container(
                            width: 300,
                            child: OTPTextField(
                                controller: otpController,
                                length: 5,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldWidth: 45,
                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 15,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                },
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      final String text1 = _textController1.text;
                      final String text2 = _textController2.text;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BillSuccess(payeeID: text1, payeeName: "Turza Podder", Amount: text2, billerName: billerName,)));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: sharedValue == "Adult"
                              ? Color(0xFFFFAE58)
                              : Color(0xFF2ECC71),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Text("Confirm",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
