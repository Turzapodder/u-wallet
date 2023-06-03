import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/Dahsboard_Container.dart';
import 'package:uwallet/forgot_otp.dart';
import 'package:uwallet/signup_phone.dart';
import 'package:uwallet/usertype.dart';
import 'package:uwallet/utils/Shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  final String? userPhone = SharedPreferenceHelper().getPhone();

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<bool> loginUser(String phoneNumber, String password) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final querySnapshot = await userCollection
        .where('phoneNumber', isEqualTo: phoneNumber)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  final TextEditingController passController = TextEditingController();

  Future<void> savePassword(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPasswordKey', pass);
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
                backgroundColor: Colors.white,
                body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Image.asset('assets/images/Logo.png',
                                  height: 150, width: 150),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Sign in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        hintText: "+88",
                                        hintStyle: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: userPhone,
                                          hintStyle: TextStyle(
                                              fontSize: 18, color: Colors.black),
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
                                  Text(
                                    "Password",
                                    style: TextStyle(color: Colors.black45),
                                  ),
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
                                controller: passController,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter your 5 digits password",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () async {
                                  savePassword(passController.text);
                                  bool loginSuccess = await loginUser(
                                      userPhone!, passController.text);
                                  if (loginSuccess) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardContainer()));
                                  } else {
                                    showToast(userType);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 100.0,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: userType == "Adult"
                                          ? Color(0xFFFFAE58)
                                          : Color(0xFF2ECC71),
                                      borderRadius: BorderRadius.circular(20.0)),
                                  child: Center(
                                    child: Text("Sign in",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Doesn’t have an account? ",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyPage()));
                                    },
                                    child: Text(
                                      "Signup",
                                      style: TextStyle(
                                          color: userType == "Adult"
                                              ? Color(0xFFFFAE58)
                                              : Color(0xFF2ECC71)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotOtpPage()));
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        color: userType == "Adult"
                                            ? Color(0xFFFFAE58)
                                            : Color(0xFF2ECC71)),
                                  ))
                          ],
                              ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        });
  }

  void showToast(String user) {
    Fluttertoast.showToast(
      msg: 'Incorrect Password!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
      textColor: Colors.white,
    );
  }
}
