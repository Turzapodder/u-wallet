import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uwallet/reg_success.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  bool _isHidden = true;
  bool _isHidden2 = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;

    });
  }
  void _toggleVisibility2() {
    setState(() {
      _isHidden2 = !_isHidden2;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text("Create New Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                children: [
                  Text(
                    'Your new password must be different from previous passwords.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                  TextFormField(
                    obscureText: _isHidden,
                    obscuringCharacter: '●',
                    style: TextStyle(fontSize: 24),
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
                        color: _isHidden? Color(0xFFBDBDBD) : Color(0xFFFFAE58),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Must be at least 5 characters.",style: TextStyle(color: Colors.black54, fontSize: 16),),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Confirm Password",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                  TextFormField(
                    obscureText: _isHidden2,
                    obscuringCharacter: '●',
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggleVisibility2,
                        icon: _isHidden2
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: _isHidden2? Color(0xFFBDBDBD) : Color(0xFFFFAE58),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.digitsOnly,
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
                              builder: (context) => RegSuccessPage()));
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
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
