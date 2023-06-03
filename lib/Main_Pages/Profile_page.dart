import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwallet/Main_Pages/connected_family.dart';
import 'package:uwallet/Main_Pages/my_QR.dart';

import 'added_members.dart';
import 'invite_contacts.dart';
import '../utils/Shared_preferences.dart';
import 'Offer_Reward_page.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final String? userName = SharedPreferenceHelper().getUserName();
  final String? balance = SharedPreferenceHelper().getBalance();
  final String? phoneNumber = SharedPreferenceHelper().getUserPhone();
  final String? profileUrl = SharedPreferenceHelper().getProfile();
  final String? sharedValue = SharedPreferenceHelper().getValue();

  String card_no="";
  String Ac_Name="";
  String bankName="";
  String expiry="";


  Future<void> retrieveBankInfo(String phoneNumber) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection('User_Bank_info').doc(phoneNumber);
      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;

        card_no=data['CardNo'];
        Ac_Name=data['ACHolder'];
        bankName=data['BankName'];
        expiry=data['ExpiryDate'];

        print('User Bank data Retrieved ');

      } else {
        print('User data not found!');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveBankInfo(phoneNumber!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading user data'),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 45, left: 15, right: 15),
                          height: 400,
                          decoration: BoxDecoration(
                            color: sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "My Profile",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the next page here
                                      Example:
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => MyQR()));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
                                        border: Border.all(
                                            width: 1, color: Colors.white60),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.qr_code,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          profileUrl!,),
                                      )
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "$userName",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        "$phoneNumber",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          right: 65,
                          child: Container(
                            height: 200,
                            width: 260,
                            decoration: BoxDecoration(
                              color: Color(0xFFCD8C4B),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -45,
                          right: 40,
                          child: Container(
                            height: 200,
                            width: 310,
                            decoration: BoxDecoration(
                              color: sharedValue == "Adult" ?  Color(0xFF2ECC71): Color(0xFFFFAE58),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -60,
                          right: 20,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 200,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFF00373E),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "Balance",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    sharedValue == "Adult" ?
                                    Text("Expiry Date: "+expiry, style: TextStyle(
                                        color: Colors.white, fontSize: 16),):
                                    Text(sharedValue!, style: TextStyle(
                                        color: Colors.white, fontSize: 16),)
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "৳ $balance",
                                  style: TextStyle(
                                    color: Colors.yellowAccent,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                sharedValue == "Adult" ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.sim_card,
                                          color: Colors.white60,
                                          size: 30,
                                        ),
                                        Text(
                                          " "+card_no,
                                          style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(bankName, style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 18,)
                                    ),
                                  ],
                                ):
                                    Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 40),
                        color: Colors.white,
                        child: bwTiles(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
    );
  }

  Widget bwTiles() {
    return Column(
      children: [
        bwTile(Icons.person, "Add or invite family", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsPage()),
          );
        }),
        bwTile(Icons.lock, "Connected Members", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sharedValue=="Adult"?AcceptedInvitationsList(phoneNumber: phoneNumber!,):AcceptedInvitationsList2(phoneNumber: phoneNumber!)),
          );
        }),
        bwTile(
          CupertinoIcons.gift,
          "Offers & Rewards",
              () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionPage(
                ),
              ),
            );
          },
        ),
        bwTile(Icons.help_rounded, "Help", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsPage()),
          );
        }),
        bwTile(Icons.logout, "Logout", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsPage()),
          );
        }),
      ],
    );
  }

  Widget bwTile(IconData icon, String text, VoidCallback onTap) {
    Color pickedColor = Color(0xfff3f4fe);
    return ListTile(
      leading: Container(
        child: Icon(icon, color: sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black38, size: 20),
      onTap: onTap,
    );
  }
}


class FamilyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Page'),
      ),
      body: Center(
        child: Text('Add or invite family page'),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Page'),
      ),
      body: Center(
        child: Text('Add or invite family page'),
      ),
    );
  }
}