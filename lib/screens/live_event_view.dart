import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LiveEventView extends StatefulWidget {
  @override
  _LiveEventViewState createState() => _LiveEventViewState();
}

class _LiveEventViewState extends State<LiveEventView> {
  @override
  Widget build(BuildContext context) {
    print(Database.box.get('authorization'));
    return Scaffold(
        body: Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('./assets/images/live_image.png'),
                  fit: BoxFit.cover)),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 10.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0)),
                      color: Colors.red,
                    ),
                    child: const Text(
                      "Live",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Icon(CupertinoIcons.eye),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Text(
                    "3K+",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.xmark_square_fill))
            ],
          ),
        )),
        Positioned(
            bottom: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                      height: 50,
                      width: 300,
                      child: userCommentTile(
                          "Michael", "Lorem Ipsum is simply", true)),
                  SizedBox(
                      height: 50,
                      width: 300,
                      child: userCommentTile(
                          "Ola", "Lorem Ipsum is simply", true)),
                  SizedBox(
                      height: 50,
                      width: 300,
                      child: userCommentTile(
                          "Chukwu", "Lorem Ipsum is simply", true)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: const TextField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                )),
                            const Text(
                              "Send",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              )),
                          const Text(
                            "2k",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Colors.white,
                            size: 15,
                          )),
                    ],
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
