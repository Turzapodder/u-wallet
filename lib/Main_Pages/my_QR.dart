import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Dahsboard_Container.dart';
import '../utils/Shared_preferences.dart';

class MyQR extends StatelessWidget {

  final String string1 = 'Turza Podder';
  final String string2 = '01871038150';
   MyQR({Key? key}) : super(key: key);

  final String? sharedValue = SharedPreferenceHelper().getValue();

  @override
  Widget build(BuildContext context) {
    String combinedString = '$string1|$string2';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),),
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => DashboardContainer(),
          ),
          ),
                }),
        title: Text("My QR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 600,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QrImage(
                data: combinedString,
                version: QrVersions.auto,
                size: 320,
                gapless: false,
                embeddedImage: AssetImage('assets/images/sm-logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(80, 80),
                ),
              ),
              SizedBox(height: 20,),
              Text("Scan The QR code to transfer money", style: TextStyle(fontSize: 16, color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}
