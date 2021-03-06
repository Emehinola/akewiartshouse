import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/screens.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter(); // initializing hive store
  await Hive.openBox('akewiartshouse');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // setting device orientation to portrait
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akewi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
      home: SplashScreen(),
    );
  }
}
