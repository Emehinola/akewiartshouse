import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // index for controlling bottom navigation
  int index = 0;

  List<String> texts = [
    "Manage posts",
    "Book store",
    "Events",
    "Donate",
    "Help/Support",
    "Settings"
  ];

  // drawer icons
  List<String> icons = [
    "manage_post",
    "bookstore",
    "events",
    "donate",
    "help",
    "settings"
  ];

  List<Widget> drawerScreens = [
    ManagePost(),
    MyBookStore(),
    MyEvents(),
    Donate(),
    Help(),
    const Scaffold()
  ];

  // navigation screens
  List<Widget> screens = [
    Home(),
    CreatePost(),
    BookStore(),
    NotificationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // print(Database.box.get('authorization'));
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.red),
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: index == 0 ? Colors.red : Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.arrow_down_doc,
                color: index == 1 ? Colors.red : Colors.black,
              ),
              label: "New post"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.book,
                color: index == 2 ? Colors.red : Colors.black,
              ),
              label: "Bookstore"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.bell,
                color: index == 3 ? Colors.red : Colors.black,
              ),
              label: "Notification"),
        ],
      ),
    );
  }
}
