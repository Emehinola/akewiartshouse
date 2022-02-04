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
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Text("Now playing",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.chevron_back,
                    color: Colors.black)),
            actions: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.ellipsis_vertical,
                  color: Colors.black,
                ),
                onPressed: () {},
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(height: 15.0),
              ClipRRect(
                child: Image.asset(
                  './assets/images/bg.jpeg',
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Oremi",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("Angelique Kidjo")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                      ),
                      Text(
                        "2k",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
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
                    color: Colors.red,
                    width: 125,
                    height: 5.0,
                  ),
                  Positioned(
                      left: 120,
                      top: 2.5,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.red),
                        height: 10.0,
                        width: 10.0,
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
                      Icon(CupertinoIcons.shuffle, color: Colors.red, size: 30),
                      Icon(CupertinoIcons.backward_end_fill,
                          color: Colors.red, size: 30),
                      Icon(CupertinoIcons.pause, color: Colors.red, size: 30),
                      Icon(CupertinoIcons.forward_end_fill,
                          color: Colors.red, size: 30),
                      Icon(CupertinoIcons.repeat, color: Colors.red, size: 30)
                    ]),
              )
            ],
          ),
        ));
  }
}
