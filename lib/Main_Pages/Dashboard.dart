import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../widgets/card_widget.dart';
import '../widgets/dashboard_container.dart';
import '../widgets/feature_buttons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset('assets/images/sm-logo.png', fit: BoxFit.cover,),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(10)

                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(AntDesign.setting, color: Colors.black87,),
                        iconSize: 20,
                        onPressed: () {
                        },
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
                      Text("Hello Turza,",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Your available Balance", style: TextStyle(fontSize: 12, color: Colors.black38),)
                    ],
                  ),

                  Text("\৳15,901", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
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
                  child: Text("Payment Features", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.start, )
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NewWidget(textLabel: "Pay Bills", iconColor: Colors.orange, iconName: Icons.flash_on,),
                        NewWidget(textLabel: "Send Money", iconColor: Color(0xFFFF6D3F), iconName: FontAwesome.money,),
                        NewWidget(textLabel: "Savings", iconColor: Color(0xFF2ECC72), iconName: FlutterIcons.receipt_faw5s,),
                        NewWidget(textLabel: "Mobile \nRecharge", iconColor: Color(0xFFFF3F3F), iconName: FontAwesome5Solid.mobile,),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NewWidget(textLabel: "History", iconColor: Color(0xFF2ECC72), iconName: MaterialCommunityIcons.credit_card_multiple,),
                        NewWidget(textLabel: "Assurance", iconColor: Colors.blueAccent, iconName: Icons.assured_workload,),
                        NewWidget(textLabel: "Payments", iconColor: Color(0xFFFFAE58), iconName: Icons.electric_bolt,),
                        NewWidget(textLabel: "More", iconColor: Colors.blueAccent, iconName: MaterialCommunityIcons.more,),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: double.infinity,
                        child: Text("Promo & Discount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.start, )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 200,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            NewWidget2(sm_title:"30% OFF", bg_title: "11.11 best deals" ,bg_color:Color(0xFF00373E),ac_color:Color(0xFF4CD080),para:"Get discount for every topup,\n transfer and payment", small: "30%",txt:Colors.white),
                            NewWidget2(sm_title:"Special Offer", bg_title: "for Today’s Top Up" ,bg_color:Color(0xFFFFD2A6),ac_color:Colors.greenAccent,para:"Get discount for every topup,\n transfer and payment", small: "Grab\n Now",txt: Colors.black,),
                            NewWidget2(sm_title:"30% OFF", bg_title: "11.11 best deals" ,bg_color:Color(0xFF00373E),ac_color:Color(0xFF4CD080),para:"Get discount for every topup,\n transfer and payment", small: "30%",txt: Colors.white,),
                          ],
                        )
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}



