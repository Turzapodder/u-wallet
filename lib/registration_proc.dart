import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/set_ID_photo_screen.dart';
import 'package:uwallet/set_birth_photo_screen.dart';

class Reg_proc extends StatelessWidget {
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
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: userType == "Adult" ? Color(0xFFFFAE58) : Color(
                0xFF2ECC71),
            title: Text(
              'Registration Process',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                    Image.asset(
                      'assets/images/proc.png',
                      height: 300,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Follow these easy steps',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              children: [
                                Row(children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      userType=="Adult"?
                                      "Take Your NID Photo": "Take Birth Certificate\n Photo",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "Fill up other information",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "Take a selfie of yours",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: SizedBox(
                              width: 180,
                              height: 40,
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
                                  // Handle "accept" button press
                                  userType=="Adult"?
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SetPhotoScreen()))
                                  :Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SetBirthPhotoScreen()));
                                },
                                child: Text(
                                  'Start',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
    );
  }
}
