import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/reg_success.dart';
import 'package:uwallet/registration_proc.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  bool _isHidden = true;
  final String userPassword = 'userPasswordKey';
  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  Future<void> savePassword(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPassword, pass);
  }
  final TextEditingController otpController1 = TextEditingController();

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
                          Text("Setup Password",
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
                      Column(
                        children: [
                          Text(
                            'Please create a  secure password including the following criteria below',
                            style: TextStyle(color: Colors.black54,
                                fontSize: 16),
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
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
                                color: Color(0xFFBDBDBD),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: otpController1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Must be at least 5 characters.",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),),
                            ],
                          ),
                          SizedBox(height: 50.0),
                          InkWell(
                            onTap: () {
                              savePassword(otpController1.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reg_proc()));
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
                                    borderRadius: BorderRadius.circular(30.0)),
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
    );
  }

}
