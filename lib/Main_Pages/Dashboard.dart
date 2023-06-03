import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/Main_Pages/Paymnet_contacts.dart';
import 'package:uwallet/Main_Pages/invite_contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/Shared_preferences.dart';
import '../widgets/card_widget.dart';
import '../widgets/dashboard_container.dart';
import '../widgets/feature_buttons.dart';
import 'My_requests.dart';
import 'Request_money.dart';
import 'bill_pay.dart';
import 'incoming_requests.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final String? phoneNumber = SharedPreferenceHelper().getPhone();
  final String? password = SharedPreferenceHelper().getPassword();
  String balance="";
  String Name="";

  Future<void> storeUserDataInSharedPreferences(
      String phoneNumber, String password) async {
    try {
      final collection = FirebaseFirestore.instance.collection('users');
      final querySnapshot = await collection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocument = querySnapshot.docs.first;
        final userData = userDocument.data();

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('name', userData['name']);
        Name=userData['name'];
        prefs.setString('phoneNumber', userData['phoneNumber']);
        prefs.setString('balance', userData['balance'].toString());
        balance=userData['balance'].toString();
        prefs.setString('profilePicUrl', userData['profilePicUrl']);

        print('User data stored in shared preferences.');
        print(prefs.getString('name'));
      } else {
        print('User not found!');
      }
    } catch (e) {
      print('Error storing user data: $e');
    }
  }

  Future<void> _storeUserData() async {
    await storeUserDataInSharedPreferences(phoneNumber!, password!);
  }

  @override
  void initState() {
    _storeUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _storeUserData(),
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
              body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(top: 50, right: 15, left: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 70,
                              child: Image.asset(
                                'assets/images/sm-logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      width: 1, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    AntDesign.setting,
                                    color: Colors.black87,
                                  ),
                                  iconSize: 20,
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Your available Balance",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black38),
                                )
                              ],
                            ),
                            Text(
                              "\৳ $balance",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        dashboard_container(),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            width: double.infinity,
                            child: Text(
                              "Payment Features",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PayBillPage()));
                                      },
                                      child: NewWidget(
                                        textLabel: "Pay Bills",
                                        iconColor: Colors.orange,
                                        iconName: Icons.flash_on,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  sharedValue == "Adult"
                                                      ? Payment_contact()
                                                      : RequestMoeny()));
                                    },
                                    child: NewWidget(
                                      textLabel: sharedValue == "Adult"
                                          ? "Send Money"
                                          : "Request Money",
                                      iconColor: Color(0xFFFF6D3F),
                                      iconName: FontAwesome.money,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              sharedValue == "Adult"
                                                  ? RequestList2(phoneNumber: phoneNumber!)
                                                  : RequestList(phoneNumber: phoneNumber!,)));
                                    },
                                    child: NewWidget(
                                      textLabel: "Requests",
                                      iconColor: Color(0xFF2ECC72),
                                      iconName: FlutterIcons.receipt_faw5s,
                                    ),
                                  ),
                                  NewWidget(
                                    textLabel: "Mobile \nRecharge",
                                    iconColor: Color(0xFFFF3F3F),
                                    iconName: FontAwesome5Solid.mobile,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  NewWidget(
                                    textLabel: "History",
                                    iconColor: Color(0xFF2ECC72),
                                    iconName: MaterialCommunityIcons
                                        .credit_card_multiple,
                                  ),
                                  NewWidget(
                                    textLabel: "Assurance",
                                    iconColor: Colors.blueAccent,
                                    iconName: Icons.assured_workload,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PayBillPage()));
                                      },
                                      child: NewWidget(
                                        textLabel: "Payments",
                                        iconColor: Color(0xFFFFAE58),
                                        iconName: Icons.electric_bolt,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ContactsPage()));
                                    },
                                    child: NewWidget(
                                      textLabel: "More",
                                      iconColor: Colors.blueAccent,
                                      iconName: MaterialCommunityIcons.more,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    "Promo & Discount",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  //padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 200,
                                  child: PageView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      NewWidget2(
                                          sm_title: "30% OFF",
                                          bg_title: "11.11 best deals",
                                          bg_color: Color(0xFF00373E),
                                          ac_color: Color(0xFF4CD080),
                                          para:
                                              "Get discount for every topup,\n transfer and payment",
                                          small: "30%",
                                          txt: Colors.white),
                                      NewWidget2(
                                        sm_title: "Special Offer",
                                        bg_title: "for Today’s Top Up",
                                        bg_color: Color(0xFFFFD2A6),
                                        ac_color: Colors.greenAccent,
                                        para:
                                            "Get discount for every topup,\n transfer and payment",
                                        small: "Grab\n Now",
                                        txt: Colors.black,
                                      ),
                                      NewWidget2(
                                        sm_title: "30% OFF",
                                        bg_title: "11.11 best deals",
                                        bg_color: Color(0xFF00373E),
                                        ac_color: Color(0xFF4CD080),
                                        para:
                                            "Get discount for every topup,\n transfer and payment",
                                        small: "30%",
                                        txt: Colors.white,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            );
          }
        });
  }
}
