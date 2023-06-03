import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:uwallet/Main_Pages/payment_success.dart';
import 'package:uwallet/Main_Pages/topup_success.dart';

import '../models/cardItem.dart';
import '../utils/Shared_preferences.dart';

class TopUpConfirm extends StatelessWidget {

  TopUpConfirm(
      {Key? key})
      : super(key: key);

  final myController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  final String? phone = SharedPreferenceHelper().getUserPhone();
  String pinValue="";
  void anotherMethod(String pin) {
    pinValue=pin;
  }
  String card_no="";
  String Ac_Name="";
  String bankName="";
  String expiry="";


  Future<void> retrieveBankInfo(String phoneNumber) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection('User_Bank_info').doc(phoneNumber);
      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;

        card_no=data['CardNo'];
        Ac_Name=data['ACHolder'];
        bankName=data['BankName'];
        expiry=data['ExpiryDate'];

        print('User Bank data Retrieved ');

      } else {
        print('User data not found!');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }



  Future<void> updateBalance(String phoneNumber, String password, String amount) async {
    try {
      final collection = FirebaseFirestore.instance.collection('users');
      final querySnapshot = await collection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocument = querySnapshot.docs.first;
        final userData = userDocument.data();
        final currentBalance = userData['balance'] ?? 0; // Assuming the balance field is named 'balance'

        final doubleAmount = double.tryParse(amount) ?? 0;

        final newBalance = currentBalance + doubleAmount;
        await userDocument.reference.update({
          'balance': newBalance,
        });

        print('Balance updated successfully!');
      } else {
        print('User not found!');
      }
    } catch (e) {
      print('Error updating balance: $e');
    }
  }



  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveBankInfo(phone!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading user data'),
          );
        } else {
           return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.orangeAccent,

                  ),
                ),
              ),
              title: Text(
                "Confirmation Page",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.orangeAccent),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 15),
                          child: Container(
                            width: 350,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color(0xFF00373E), //Color(0xFF00373E),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bankName.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      Ac_Name.toUpperCase(),
                                      style:
                                      TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          child: Image.network(
                                            "https://pbs.twimg.com/profile_images/1631675821000732673/A-TbmF9W_400x400.png",
                                            fit: BoxFit.contain,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                          "A/C " + card_no,
                                          style:
                                          TextStyle(color: Colors.white,
                                              fontSize: 18),
                                        )),
                                    Text(
                                      expiry,
                                      style:
                                      TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Set Amount",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "How much would you like to TopUp?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 16.0),
                            hintText: "৳  Enter Amount",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0,
                                fontSize: 18,
                                color: Colors.black26),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.withOpacity(.5)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFFAE58)),
                            ),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {},
                          controller: myController,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text("Confirm Password",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            child: OTPTextField(
                                controller: otpController,
                                length: 5,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                textFieldAlignment: MainAxisAlignment
                                    .spaceAround,
                                fieldWidth: 45,
                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 15,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                onChanged: (pin) {},
                                onCompleted: (pin) {
                                  anotherMethod(pin);
                                }
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        InkWell(
                          onTap: () async {
                            String amount = myController.text;
                            print(phone);
                            print(pinValue);
                            print(amount);
                            await updateBalance(phone!, pinValue, amount);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TopUpPage(amount: amount)));
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFAE58),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: Text("Top Up Now",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
