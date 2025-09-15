import 'dart:async';
import 'package:carinspect/Home.dart';
import 'package:carinspect/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Myapp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      // initialRoute: '/',
      home: const SplashScreen(),
      // routes: {
      //   'SplashScreen': (context) => SplashScreen(),
      //   '/Events': (context) => Events(),
      // },
      //{'SplashScreen': (BuildContext context) => Events()},
      // builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();

    // Timer(
    //     const Duration(seconds: 2, milliseconds: 50),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => const Login())));
  }

  checkLogin() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? Token = sharedprefrence.getString("Token");

    if (Token.toString() == "null") {
      Timer(
        const Duration(seconds: 2, milliseconds: 50),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 2, milliseconds: 50),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/HeartBeat _ Medical.gif', // Replace with the path to your Lottie JSON file
                // fit: BoxFit.cover,
                width: 100, // Adjust the width and height as needed
                height: 100,
                // repeat: true, // Set to true if you want the animation to loop
              ),
            ),
            Center(
              child: Text(
                "Welcome to My Cars Doctor",
                style: TextStyle(
                  color: Color.fromARGB(255, 209, 8, 8),
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
