import 'dart:io';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        await http.get(Uri.parse('https://google.com'));
        if ((Database.box.get('email') != null) &&
            Database.box.get('isLoggedIn')) {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => NavigationScreen()));
        } else {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => WelcomeScreen()));
        }
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No internet connection")));
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Builder(builder: (context) {
          return Center(
            child: Image.asset("./assets/images/logo.png",
                height: 100, width: 100),
          );
        });
      }),
    );
  }
}
