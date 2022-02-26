import 'package:akewiartshouse/backend/getter.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> texts = ["Manage posts", "Book store", "Events", "Donate", "Help/Support", "Settings"];

    // drawer icons
    List<String> icons = ["manage_post", "bookstore", "events", "donate", "help", "settings"];

    List<Widget> drawerScreens = [ManagePost(), MyBookStore(), MyEvents(), Donate(), Help(), Scaffold()];
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Scaffold(
      drawer: Container(
        key: _drawerKey,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.8,
        color: Colors.white,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('./assets/images/profile_image.png'),
                          ),
                        ),
                      ),
                      const Text(
                        "Emeh Sam",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Text(
                        "Samurl",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "15",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "posts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "6k",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "likes",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.person_alt_circle_fill,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Manage Profile",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 450,
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => drawerScreens[index])),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("./assets/images/${icons[index]}.png"),
                            const SizedBox(height: 10.0),
                            Text(
                              texts[index],
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                height: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Developed by Placid Global Intl.",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        "(Akewi Artshouse limited)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  await Database.box.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WelcomeScreen(),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.square_arrow_left_fill),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.asset('./assets/images/home_bg.png'),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                ),
                Container(
                  height: 300,
                  decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.75), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(height: 35),
                  Image.asset('./assets/images/logo.png', height: 70, width: 60),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Hi Sam, Welcome to AKEWI!",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text("Select a category to explore", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      content: SizedBox(
                                        height: 250,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text("Select an option", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                        CupertinoIcons.xmark,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () => Navigator.pop(context))
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height: 200,
                                                padding: const EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(40.0),
                                                ),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  GestureDetector(
                                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Literature())),
                                                    child: SizedBox(
                                                      height: 120,
                                                      width: 70,
                                                      child: literatureOptionsCard("Poetry", "./assets/images/poem.png"),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Drama())),
                                                    child: SizedBox(
                                                      height: 120,
                                                      width: 70,
                                                      child: literatureOptionsCard("Drama", "./assets/images/drama.png"),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Essay())),
                                                    child: SizedBox(
                                                      height: 120,
                                                      width: 70,
                                                      child: literatureOptionsCard("Essay", "./assets/images/essay.png"),
                                                    ),
                                                  ),
                                                ])),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: itemCard("Literature", "./assets/images/book_outline.png", Colors.red)),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const BookStore())), child: itemCard("Book Store", "./assets/images/page-1.png", Colors.blue)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => Events())),
                        child: itemCard("Events", "./assets/images/red-carpet.png", Colors.black),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => Music())),
                        child: itemCard("Music", "./assets/images/music-note.png", Colors.greenAccent),
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
                        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => Politics())),
                        child: itemCard("Politics", "./assets/images/Flat.png", Colors.blue),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => Editorial())),
                        child: itemCard("Editorial", "./assets/images/editorial-design.png", Colors.pink),
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
                    onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => ArtWork())),
                    child: Container(
                      height: 130,
                      width: 310,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, offset: Offset(0, 5), spreadRadius: 0, blurRadius: 3.0),
                        ],
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset('./assets/images/photo.png', height: 70, width: 70),
                          const Text("Photography and Painting ", style: TextStyle(fontWeight: FontWeight.bold)),
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
          ),
          SafeArea(
            child: IconButton(
              onPressed: () {
                if (_drawerKey.currentState != null) {
                  _drawerKey.currentState!.openDrawer();
                }
              },
              icon: const Icon(
                CupertinoIcons.bars,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
