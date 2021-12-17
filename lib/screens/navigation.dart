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
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Akewi Arts House"),
        leading:
            IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bars)),
        actions: [
          Row(
            children: [
              const Text(
                "Sam",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30.0)),
                child: IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ProfilePage())),
                    icon: const Icon(CupertinoIcons.person_alt)),
              )
            ],
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            './assets/images/bg.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black45,
          ),
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                        const Literature())),
                            child: itemCard("Literature",
                                "./assets/images/lit.jpg", Colors.red)),
                        const SizedBox(
                          width: 70,
                        ),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const BookStore())),
                            child: itemCard("Book Store",
                                "./assets/images/books.jpg", Colors.blue)),
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
                                  builder: (BuildContext context) => Events())),
                          child: itemCard("Events",
                              "./assets/images/events.jpg", Colors.black),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) => Music())),
                          child: itemCard("Music", "./assets/images/music.jpg",
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
                          child: itemCard("Politics\n\n",
                              "./assets/images/politics.jpg", Colors.blue),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ArtWork())),
                          child: itemCard("Paintings \n& \nPhotography",
                              "./assets/images/painting.jpg", Colors.pink),
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
                      onTap:()=>Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context)=>Editorial())),
                      child: itemCard("Editorial", "./assets/images/teaching.jpeg",
                          Colors.deepOrange),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const SizedBox(
                      width: 100,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
