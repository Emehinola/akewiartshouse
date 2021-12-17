import 'package:flutter/material.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Music"),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.chevron_back)),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.blueGrey, Colors.grey],
                      begin: Alignment.topCenter,
                      end: AlignmentDirectional.bottomCenter)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          './assets/images/bg.jpeg',
                          height: 200,
                          width: 150,
                        )),
                  ),
                  const Text(
                    "ROCKSTAR.",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    "(feat. roddy ricch)",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.lightBlueAccent),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(CupertinoIcons.play_arrow_solid),
                                SizedBox(width: 7),
                                Text("Play")
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.shuffle,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 7),
                                Text("Shuffle",
                                    style: TextStyle(color: Colors.white))
                              ],
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Top Tracks",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MusicDisplay())),
                    child: musicRow("1", "./assets/images/bg.jpeg", "Rockstar",
                        "(feat. roddy ricch)"),
                  ),
                  const SizedBox(height: 7),
                  musicRow("2", "./assets/images/music.jpg", "Afro Pop",
                      "(feat. olamide)"),
                  const SizedBox(height: 7),
                  musicRow("3", "./assets/images/painting.jpg", "Hip Pop",
                      "(feat. Wizkid)")
                ],
              ),
            )
          ],
        ));
  }
}
