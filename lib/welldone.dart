import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/login_screen.dart';

class Welldone extends StatelessWidget {

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
              backgroundColor: Colors.white,
              body: Column(children: <Widget>[
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Well Done!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Your profile is now being reviewed. You can expect it to finish in the next 24 hours",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          userType=="Adult"?
                          Image.asset(
                            'assets/images/well_done.png', fit: BoxFit.cover,)
                              :Image.asset(
                            'assets/images/well_done2.png', fit: BoxFit.cover,)
                          ,

                          Center(
                            child: ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 40.0),
                                child: Text('Finish', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              ),
            );
          }
        }
    );
  }
}
