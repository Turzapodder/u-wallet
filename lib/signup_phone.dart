import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uwallet/Otp_screen.dart';

//import 'otp.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  bool _is11DigitsEntered = false;
  @override
  Widget build(BuildContext context) {
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
                        //hintText: "(+88)",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(40)),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            '(+88)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: _is11DigitsEntered
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 32,
                                )
                              : null,
                        ),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        setState(() {
                          _is11DigitsEntered = value.length == 11;
                        });
                      },
                      controller: myController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    OtpPage(number: myController.text)),
                          );
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
<<<<<<< HEAD
                              fontSize: 16,
=======
                              fontSize: 18,
>>>>>>> master
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
