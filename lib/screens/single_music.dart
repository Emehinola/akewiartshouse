import 'package:flutter/material.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';

class MusicDisplay extends StatefulWidget {
  @override
  _MusicDisplayState createState() => _MusicDisplayState();
}

class _MusicDisplayState extends State<MusicDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("On high ft. roddy ricch"),
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
                  const SizedBox(height: 15.0),
                  const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                          backgroundImage: AssetImage(
                        './assets/images/bg.jpeg',
                      )),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: Text("Now Playing...",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        roundedContainer(const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.white,
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 4.5),
                          width: double.infinity,
                          height: 5.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12.0))),
                      Container(
                        margin: const EdgeInsets.only(top: 4.5),
                        color: Colors.lightBlue,
                        width: 100,
                        height: 5.0,
                      ),
                      Positioned(
                          left: 90,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.red),
                            height: 15.0,
                            width: 15.0,
                          ))
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("0:59", style: TextStyle(color: Colors.black)),
                        Text("2:02")
                      ]),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(CupertinoIcons.shuffle,
                              color: Colors.white, size: 30),
                          Icon(CupertinoIcons.backward_end_fill,
                              color: Colors.white, size: 30),
                          Icon(CupertinoIcons.pause,
                              color: Colors.white, size: 30),
                          Icon(CupertinoIcons.forward_end_fill,
                              color: Colors.white, size: 30),
                          Icon(CupertinoIcons.repeat,
                              color: Colors.white, size: 30)
                        ]),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
