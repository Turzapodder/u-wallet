import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Main_Pages/Transaction_page.dart';
import 'package:uwallet/Main_Pages/notification_page.dart';

import 'Main_Pages/Dashboard.dart';
import 'Main_Pages/Profile_page.dart';

class DashboardContainer extends StatefulWidget {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
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
        backgroundColor: Colors.orangeAccent,
        onPressed: (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        activeColor: Colors.orangeAccent,
        inactiveColor: Colors.grey,
        onTap: _navigateBottomBar,
        //other params
      ),
     /* bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.orangeAccent,
        color: Colors.orangeAccent,
        animationDuration: Duration(milliseconds: 300),

        onTap: _navigateBottomBar,
        items:[
        Icon(Foundation.home,
        color: Colors.white,),
        Icon(Icons.qr_code,
          color: Colors.white,),
        Icon(Icons.person,
          color: Colors.white, size: 25,),
      ],
      ),*/
    );
  }
}
