import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uwallet/Provider/auth_provider.dart';
import 'package:uwallet/set_password.dart';
import 'package:uwallet/splashscreen.dart';
import 'package:uwallet/utils/Shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper().initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'passwordPage': (context) => PasswordPage(),
      },

      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily:'DMSans',

      ),
      home: SplashScreen(),
    );
  }
}

