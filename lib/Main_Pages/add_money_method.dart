import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Main_Pages/Bank_information.dart';
import 'package:uwallet/utils/Procedure_row.dart';

class AddMoneyMethod extends StatelessWidget {
  const AddMoneyMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFAE58),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFFFAE58),
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              "Select Method",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Select top up methods",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Bank_information()));
                      },
                      child: Container(
                        height:60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(AntDesign.bank, color: Color(0xFFFFAE58), size: 30,),
                              Text("Bank Transfer", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height:60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(AntDesign.qrcode, color: Color(0xFF2ECC71), size: 30,),
                            Text("Bkash/Nagad/Rocket", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Read Instruction", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    SizedBox(height: 10,),
                    Text("A step by step guide on how to top up with bank transfer", style: TextStyle(wordSpacing: 2, color: Colors.grey),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                      child: Column(
                        children: [
                          Procedure(text: "Insert your Bank A/C no. and enter your PIN.", userType: "Teenager",size: 13),
                          SizedBox(height: 20,),
                          Procedure(text: "Select TRANSFER and click Bank Virtual\nAccount.", userType: "Teenager",size: 13),
                          SizedBox(height: 20,),
                          Procedure(text: "Enter top up amount.", userType: "Teenager",size: 13),
                          SizedBox(height: 20,),
                          Procedure(text: "Follow the next instructions to complete\ntop-up.", userType: "Teenager",size: 13)
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
