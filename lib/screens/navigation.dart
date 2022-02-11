import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.asset('./assets/images/home_bg.png'),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                ),
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.75),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0))),
                )
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Image.asset('./assets/images/logo.png',
                          height: 70, width: 60),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Hi Sam, Welcome to AKEWI!",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Text("Select a category to explore",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          content: SizedBox(
                                            height: 250,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      12.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            "Select an option",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      IconButton(
                                                          icon: const Icon(
                                                            CupertinoIcons
                                                                .xmark,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    height: 200,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        Literature())),
                                                            child: SizedBox(
                                                              height: 120,
                                                              width: 70,
                                                              child: literatureOptionsCard(
                                                                  "Poetry",
                                                                  "./assets/images/poem.png"),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        Drama())),
                                                            child: SizedBox(
                                                              height: 120,
                                                              width: 70,
                                                              child: literatureOptionsCard(
                                                                  "Drama",
                                                                  "./assets/images/drama.png"),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        Essay())),
                                                            child: SizedBox(
                                                              height: 120,
                                                              width: 70,
                                                              child: literatureOptionsCard(
                                                                  "Essay",
                                                                  "./assets/images/essay.png"),
                                                            ),
                                                          ),
                                                        ])),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: itemCard(
                                  "Literature",
                                  "./assets/images/book_outline.png",
                                  Colors.red)),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          const BookStore())),
                              child: itemCard("Book Store",
                                  "./assets/images/page-1.png", Colors.blue)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Events())),
                            child: itemCard("Events",
                                "./assets/images/red-carpet.png", Colors.black),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Music())),
                            child: itemCard(
                                "Music",
                                "./assets/images/music-note.png",
                                Colors.greenAccent),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Politics())),
                            child: itemCard("Politics",
                                "./assets/images/Flat.png", Colors.blue),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Editorial())),
                            child: itemCard(
                                "Editorial",
                                "./assets/images/editorial-design.png",
                                Colors.pink),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) => ArtWork())),
                        child: Container(
                          height: 130,
                          width: 310,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 5),
                                  spreadRadius: 0,
                                  blurRadius: 3.0),
                            ],
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset('./assets/images/photo.png',
                                  height: 70, width: 70),
                              const Text("Photography and Painting ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 3)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.arrow_down_doc,
                color: Colors.black,
              ),
              label: "Add new"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.book,
                color: Colors.black,
              ),
              label: "Book store"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
                color: Colors.black,
              ),
              label: "Notification"),
        ],
      ),
    );
  }
}
