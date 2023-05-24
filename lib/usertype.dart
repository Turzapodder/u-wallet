import 'package:flutter/material.dart';
import 'package:uwallet/termsconditons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatelessWidget {

  final String userTypeKey = 'userTypeKey';

  Future<void> saveUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userTypeKey, userType);
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTypeKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFFFAE58),
        title: Text('User Information',  style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/usertype.PNG', height: 300,),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'User Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: Text(
                      textAlign:TextAlign.center,
                      'Select the user type based on your age. if you are under 18 select teenager and if over 18 select Adult',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Color(0xFFFFAE58),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                saveUserType("Adult");
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                              },
                              child: Text('Adult', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),),
                            ),
                        ),
                        SizedBox(
                          width: 50,
                        ),

                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              side: BorderSide(width:2, color: Color(0xFFFFAE58)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              saveUserType("Teenager");
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                            },
                            child: Text('Teenager',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFAE58), fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
