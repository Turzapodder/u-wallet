import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/set_profile_photo_screen.dart';

class PersonalInfoPage extends StatelessWidget {

  late final File nidImage;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController nidController = TextEditingController();

  PersonalInfoPage({required this.nidImage,Key? key}) : super(key: key);

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
  }

  Future<void> saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userNameKey', name);
  }

  Future<void> saveFather(String father) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userFatherKey', father);
  }

  Future<void> saveMother(String mother) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userMotherKey', mother);
  }

  Future<void> saveNID(String nid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userNidKey', nid);
  }

  Future<void> saveCitizen(String citizen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userNationalKey', citizen);
  }

  Future<void> saveAddress(String add) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAddressKey', add);
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
                backgroundColor:
                    userType == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
                title: Text(
                  'Personal Information',
                  style: TextStyle(fontFamily: "Titillium Web"),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20.0, right: 20.0, bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please check if all the NID information is Correct',
                        style: TextStyle(
                          color: Colors.black26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: fatherNameController,
                        decoration: InputDecoration(
                          labelText: 'Father Name',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: motherNameController,
                        decoration: InputDecoration(
                          labelText: 'Mother Name',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: citizenshipController,
                        decoration: InputDecoration(
                          labelText: 'Citizenship',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: nidController,
                        decoration: InputDecoration(
                          labelText: 'NID no.',
                          labelStyle: TextStyle(
                              color: userType == "Adult"
                                  ? Color(0xFFFFAE58)
                                  : Color(0xFF2ECC71),
                              fontFamily: "Titillium Web"),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            saveName(firstNameController.text +
                                " " +
                                lastNameController.text);
                            saveFather(fatherNameController.text);
                            saveMother(motherNameController.text);
                            saveAddress(addressController.text);
                            saveCitizen(citizenshipController.text);
                            saveNID(nidController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetProfilePhotoScreen(nid_bc_image:nidImage),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: userType == "Adult"
                                ? Color(0xFFFFAE58)
                                : Color(0xFF2ECC71),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 40.0),
                            child: Text('Next Step'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
