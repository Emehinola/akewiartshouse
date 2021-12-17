import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'screens.dart';

class Literature extends StatefulWidget {
  const Literature({Key? key}) : super(key: key);

  @override
  _LieratureState createState() => _LieratureState();
}

class _LieratureState extends State<Literature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back)),
        title: const Text("Literature"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Poetry",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                Text(">"),
                Text(
                  "Drama",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(">"),
                Text(
                  "Essay/Prose",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: Offset(0, 1),
                    color: Colors.lightBlue)
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const PoetryDetailScreen())),
              child: Container(
                height: 105,
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                            './assets/images/bg.jpeg',
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Burnt Coins",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Text("by Enoch Ojotisa"),
                              Text("Click to read poetry",
                                  style: TextStyle(color: Colors.red))
                            ],
                          ),
                        ),
                      ]),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.chat_bubble)),
                    const Text("201"),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart)),
                    const Text("1.1k+")
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 0.8,
                          spreadRadius: 1.0,
                          offset: Offset(1, 1),
                          color: Colors.black12)
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 105,
              padding: const EdgeInsets.all(15.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          './assets/images/bg.jpeg',
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Holes",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            Text("by Enoch Ojotisa"),
                            Text("Click to read poetry",
                                style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                    ]),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.chat_bubble)),
                  const Text("981"),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.heart_fill,
                          color: Colors.red)),
                  const Text("2k")
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 0.8,
                        spreadRadius: 1.0,
                        offset: Offset(1, 1),
                        color: Colors.black12)
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 105,
              padding: const EdgeInsets.all(15.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          './assets/images/bg.jpeg',
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Mood Swings",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            Text("by Enoch Ojotisa"),
                            Text("Click to read poetry",
                                style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                    ]),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.chat_bubble)),
                  const Text("46"),
                  IconButton(
                      onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
                  const Text("198")
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 0.8,
                        spreadRadius: 1.0,
                        offset: Offset(1, 1),
                        color: Colors.black12)
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
