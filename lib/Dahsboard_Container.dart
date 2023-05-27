import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Main_Pages/QR_Scanner.dart';
import 'package:uwallet/Main_Pages/Transaction_page.dart';
import 'package:uwallet/Main_Pages/notification_page.dart';
import 'package:uwallet/utils/Shared_preferences.dart';

import 'Main_Pages/Dashboard.dart';
import 'Main_Pages/Profile_page.dart';

class DashboardContainer extends StatefulWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  int _selectedIndex=0;

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Dashboard(),
    TransactionPage(),
    NotitcationTap(),
    AccountPage(),
  ];

  final iconList = <IconData>[
    Foundation.home,
    Icons.bar_chart,
    Icons.notifications,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        //params
        child: Icon(Icons.qr_code, color: Colors.white,),
        backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scanner(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        activeColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
        inactiveColor: Colors.grey,
        onTap: _navigateBottomBar,
        //other params
      ),
    );
  }
}
