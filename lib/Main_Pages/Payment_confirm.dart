import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/style.dart';
import 'package:uwallet/Main_Pages/payment_success.dart';
import 'package:uwallet/utils/Shared_preferences.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../contacts.dart';

class Payment_confirm_page extends StatefulWidget {
  final String displayName;
  final String familyName;
  final String phoneNumber;

  const Payment_confirm_page({
    Key? key,
    required this.displayName,
    required this.familyName,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<Payment_confirm_page> createState() => _Payment_confirm_pageState();
}

class _Payment_confirm_pageState extends State<Payment_confirm_page> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final myController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  void initState() {
    super.initState();
  }

  Widget _buildAvatar(String displayName) {
    final NameInitials = displayName ?? '';

    return CircleAvatar(
      radius: 40,
      backgroundColor:
          sharedValue == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      child: Text(
        NameInitials.isNotEmpty ? displayName[0].toUpperCase() : '',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            "Confirm Transfer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Titillium Web',
            ),
          ),
          backgroundColor:
              sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: sharedValue == "Adult"
                    ? Color(0xFFFFAE58)
                    : Color(0xFF2ECC71),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAvatar(widget.displayName),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.displayName + " " + widget.familyName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.phoneNumber}',
                    style: TextStyle(
                        letterSpacing: 1.5, fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Transfer on ' +
                        DateFormat('EEEE, MMM d, yyyy').format(now).toString(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Set Amount",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "How much would you like to transfer?",
                    style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.3), ),
                  ),
                  SizedBox( height: 12,),
                  TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                      /*prefixText: '৳',
                      prefixStyle: TextStyle( color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),*/
                      hintText: "৳  Enter Amount",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                          fontSize: 18,
                          color: Colors.black26
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(.5)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71)),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                    },
                    controller: myController,
                  ),
                  SizedBox( height: 40,),
                  Text("Confirm Password",style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox( height: 20,),
                  Center(
                    child: Container(
                      width: 300,
                      child: OTPTextField(
                          controller: otpController,
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 15,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                          }),
                    ),
                  ),
                  SizedBox(height: 80,),
                  InkWell(
                    onTap: () {
                      String amount = myController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaveContainerPage(
                            amount: amount,
                            Name : widget.displayName + " " + widget.familyName,
                            number: widget.phoneNumber,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                          borderRadius: BorderRadius.circular(
                              20.0)),
                      child: Center(
                        child: Text("Transfer Money",
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
