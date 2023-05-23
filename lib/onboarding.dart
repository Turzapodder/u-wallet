import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:uwallet/login_screen.dart';
import 'package:uwallet/welcome.dart';
import 'models/onboard_model.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/o1.PNG',
      text: "Fastest Payment",
      desc:
      "QR code scanning technology makes your payment process more faster",
      bg: Colors.white,
      button: Color(0xFFFFAE58),
    ),
    OnboardModel(
      img: 'assets/images/o2.PNG',
      text: "Safest Platform",
      desc: "Multiple verification and face ID makes your account more safely",
      bg: Colors.white,
      button: Color(0xFFFFAE58),
    ),
    OnboardModel(
      img: 'assets/images/o3.PNG',
      text: "Pay Anything",
      desc: "Supports many types of payments and pay without being complicated",
      bg: Colors.white,
      button: Color(0xFFFFAE58),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFAE58),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    screens[index].img,
                    height: 350,
                    width: 350,
                  ),
                  Container(
                    height: 20.0,
                    child: Center(
                      child: ListView.builder(
                        itemCount: screens.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  width: currentIndex == index ? 14 : 8,
                                  height: currentIndex == index ? 14 : 8,
                                  decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? Color(0xFFFFAE58)
                                        : Color(0xff595858).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                              ]);
                        },
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: Color(0xFFFFAE58),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 24,),
                      child: Column(
                        children: [
                          Text(
                            screens[index].text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            screens[index].desc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              print(index);
                              if (index == screens.length - 1) {
                                await _storeOnboardInfo();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()));
                              }

                              _pageController.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 100.0,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        currentIndex == screens.length - 1
                                            ? "Get Started"
                                            : "Next",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),

                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}