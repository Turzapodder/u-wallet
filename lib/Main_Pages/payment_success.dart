import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Main_Pages/Dashboard.dart';

import '../Dahsboard_Container.dart';
import '../utils/Shared_preferences.dart';
import 'Paymnet_contacts.dart';

class WaveContainerPage extends StatelessWidget {
  final String? sharedValue = SharedPreferenceHelper().getValue();

  final String amount;
  final String Name;
  final String number;

  WaveContainerPage(
      {required this.amount,required this.number,required this.Name,
        Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 80,
            ),
            child: Text("Transfer Receipt",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: ClipPath(
              clipper: MultipleRoundedCurveClipper(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                width: double
                    .infinity, // Set the background color of the container
                height: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: Image.asset('assets/images/img_1.png',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Transfer Success",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Your money has been successfully sent to "+Name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Total Transfer",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text("৳ "+amount,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Recipient",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: sharedValue == "Adult"
                                    ? Color(0xFF2ECC71)
                                    : Color(0xFFFFAE58)),
                            child: Center(
                              child: Icon(
                                FontAwesome.user,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(number,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DashboardContainer()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,

                        decoration: BoxDecoration(
                            color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                            borderRadius: BorderRadius.circular(
                                20.0)),
                        child: Center(
                          child: Text("Done",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Payment_contact()));
                        },
                        child: Text(
                          "Transfer more money", style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
