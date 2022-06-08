import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../icons/my_flutter_app_icons.dart';
import 'screens.dart';

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

  bool authenticated = false;

  @override
  void initState() {
    authenticated = Database.box.get('isLoggedIn', defaultValue: false);
    super.initState();
  }

  // snackbar for telling user to login
  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login to have full access")));
  }

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
          if (!authenticated) {
            showSnackBar();
            return;
          }
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: index == 0 ? Colors.red : Colors.black,
                size: 28,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.vector,
                color: index == 1 ? Colors.red : Colors.black,
              ),
              label: "New post"),
          BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.vector_3,
                color: index == 2 ? Colors.red : Colors.black,
              ),
              label: "Bookstore"),
          BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.vector_1,
                color: index == 3 ? Colors.red : Colors.black,
              ),
              label: "Notification"),
        ],
      ),
    );
  }
}
