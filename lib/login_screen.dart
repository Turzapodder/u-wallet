import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uwallet/create_new_password.dart';
import 'package:uwallet/forgot_otp.dart';
import 'package:uwallet/signup_phone.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Logo.png', height: 150, width: 150),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Sign in",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      SizedBox(height: 25,),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "+880",
                                //border: BorderSide(width: 3, ),
                                hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: TextFormField(
                                enabled: false,
                                  decoration: InputDecoration(
                                    hintText: "018 710 38 150",
                                    hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                                  ),
                              ),
                            ),
                          )

                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Password", style: TextStyle(color: Colors.black45), ),
                        ],
                      ),
                      TextFormField(
                        obscureText: _isHidden,
                        obscuringCharacter: '●',
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          suffixIcon: IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            color: Color(0xFFBDBDBD),

                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Enter your 5 digits password", style: TextStyle(color: Colors.black45), ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
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
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xFFFFAE58),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign in",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Doesn’t have an account? ", style: TextStyle(color: Colors.black45), ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Register()));
                          },
                            child: Text("Signup", style: TextStyle(color: Color(0xFFFFAE58)),),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotOtpPage()));
                        },
                          child: Text("Forgot password?", style: TextStyle(color: Color(0xFFFFAE58)), )),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
