import 'package:flutter/material.dart';
import 'package:uwallet/Main_Pages/Top_up_confirm.dart';
import 'package:uwallet/Main_Pages/payment_success.dart';

import '../models/cardItem.dart';
import '../utils/Shared_preferences.dart';

class Bank_information extends StatefulWidget {
  const Bank_information({Key? key}) : super(key: key);

  @override
  State<Bank_information> createState() => _Bank_informationState();
}

class _Bank_informationState extends State<Bank_information> {
  List<CardItem> items = [
    CardItem(
        img:
            "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/032014/dhaka_bank_logo.png?itok=G4DW7ltu",
        text: "Dhaka Bank"),
    CardItem(
        img:
            "https://www.businessinsiderbd.com/media/imgAll/2020October/en/Sibl-Logo-2107291046.jpg",
        text: "SIBL Bank"),
    CardItem(
        img:
            "https://pbs.twimg.com/profile_images/1631675821000732673/A-TbmF9W_400x400.png",
        text: "Citi Bank"),
    CardItem(img: "https://baplc.org/upload/DBBL.jpg", text: "DBBL"),
    CardItem(
        img:
            "https://prod-media-eng.dhakatribune.com/uploads/2021/02/whitagram-image-1613509062147.jpg",
        text: "NRBC Bank"),
    CardItem(
        img:
            "https://play-lh.googleusercontent.com/5VIzZSLHl0PmM6vIZeaRoD_UzxZLvl8c3nBE90L2fxC7T__aYYCLn81PFc86sTlPqPo=w240-h480-rw",
        text: "HSBC Bank"),
    CardItem(
        img:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/EBL_Registered_Corporate_Logo.svg/220px-EBL_Registered_Corporate_Logo.svg.png",
        text: "EBL"),
    CardItem(
        img:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Janata_Bank_Logo.svg/512px-Janata_Bank_Logo.svg.png",
        text: "Janata Bank"),
    CardItem(
        img:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Sonali_Bank_Limited.svg/1280px-Sonali_Bank_Limited.svg.png",
        text: "Sonali Bank"),
  ];
  final TextEditingController nameControl = TextEditingController();
  final TextEditingController cardControl = TextEditingController();
  final TextEditingController ExpiryControl = TextEditingController();
  final TextEditingController cvvControl = TextEditingController();
  late CardItem selectedCard;

  int selectedIndex= -1;
  void selectCard(CardItem card) {
    setState(() {
      selectedCard = card;
    });

    // Perform any additional operations with the selected card data
    print('Selected card: ${card.text}');
    print('Selected card image: ${card.img}');
  }
  @override
  void dispose() {
    nameControl.dispose();
    cardControl.dispose();
    ExpiryControl.dispose();
    cvvControl.dispose();
    super.dispose();
  }

  void navigateToDestinationPage() {

    String NameData = nameControl.text;
    String CardData = cardControl.text;
    String expireData = ExpiryControl.text;
    String cvvData = cvvControl.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopUpConfirm(
          selectedCard: selectedCard,
          nameData: NameData,
            cardData:CardData,
          cvvData: cvvData,
          expireData: expireData,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFAE58),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFFFAE58),
            title: Text(
              "Top Up with Bank",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Select Bank",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15),
                    child: Container(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 9,
                        separatorBuilder: (context, _) => SizedBox(width: 10),
                        itemBuilder: (context, index) => InkWell(
                          onTap: (){
                            setState(() {
                              selectedIndex = index;
                              selectCard(items[index]);
                            });
                          },
                          child: buildCard(item: items[index],  check: selectedIndex==index?true:false),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Banking Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Bank_textField(
                          controller: nameControl,
                          label: "Account holder name",
                          type: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Bank_textField(
                          controller: cardControl,
                          label: "Card Number",
                          type: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Bank_textField(
                                controller: ExpiryControl,
                                label: "Expiry Date",
                                type: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Bank_textField(
                                controller: cvvControl,
                                label: "3-digit CVV",
                                type: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        InkWell(
                          onTap: () {
                            navigateToDestinationPage();
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFAE58),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: Text("Continue",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class Bank_textField extends StatelessWidget {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final TextEditingController controller;
  final String label;
  final TextInputType type;

  Bank_textField({
    required this.controller,
    required this.label,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey, fontFamily: "Titillium Web"),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: sharedValue == "Adult"
                  ? Color(0xFFFFAE58)
                  : Color(0xFF2ECC71)),
        ),
      ),
    );
  }
}

Widget buildCard({
  required CardItem item,
  required bool check,
}) =>
    Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: check==false?Colors.white:Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: Image.network(item.img, fit: BoxFit.contain)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            item.text,
            style: TextStyle(fontWeight: FontWeight.bold, color: check==false?Colors.black:Colors.white),
          )
        ],
      ),
    );
