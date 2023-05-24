import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/login_screen.dart';
import 'package:uwallet/registration_proc.dart';
import 'package:uwallet/signup_phone.dart';

class TermsAndConditionsPage extends StatelessWidget {

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
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
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
              title: Text('Terms and Conditions',
                style: TextStyle(fontWeight: FontWeight.w400),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          'User Policy & Terms',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22)
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        'Your terms and conditions text goes here. It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and '
                            '\n\n''will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.'
                            '\n\n''It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.'
                            '\n\n''It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.'
                            '\n\n''It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable.It can be quite long and will be scrollable. lorem ipsum',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            side: BorderSide(
                                width: 2, color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text('Decline', style: TextStyle(
                              color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                            elevation: 0,
                            side: BorderSide(
                                width: 2, color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text('Accept', style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }
}
