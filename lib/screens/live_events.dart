import 'dart:io';

import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/live_event_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveEvent extends StatelessWidget {
  // open past event on youtube
  void openYoutube(String youtubeId) async {
    var link = "https://youtube.com/?watch/?v=$youtubeId";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(link)) {
        await launch(link, forceSafariVC: false);
      } else {
        //
      }
    }

    // launching based on platform
    else if (Platform.isIOS) {
      //
    } else if (Platform.isAndroid) {
      if (await canLaunch(link)) {
        launch(link); // launches whatsapp
      } else {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () => openYoutube(''),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  './assets/images/events.jpg',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black45],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  child: const Icon(
                    FontAwesomeIcons.youtube,
                    color: Colors.red,
                    size: 35,
                  ),
                ),
                Positioned(
                    bottom: 3,
                    left: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "The title of the post goes here... akhiugurh eryug iuerguiiug",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.time,
                                  color: Colors.white,
                                ),
                                Text(
                                  "21, April, 2021",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.chat_bubble,
                                  color: Colors.white,
                                ),
                                Text(
                                  "28",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 65,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Home Drive Hangout",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "GBVN Hangout",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(CupertinoIcons.heart, color: Colors.grey),
                      Text("46", style: TextStyle(color: Colors.black54)),
                      SizedBox(width: 15.0),
                      Icon(
                        FontAwesomeIcons.shareAlt,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text("198", style: TextStyle(color: Colors.black54)),
                      SizedBox(width: 15.0),
                      Icon(CupertinoIcons.chat_bubble, color: Colors.grey),
                      Text("198", style: TextStyle(color: Colors.black54))
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "Event description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
            style: TextStyle(fontSize: 12),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 5.0),
          //   child: Text(
          //     "Comments",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const Divider(
          //   color: Colors.black,
          // ),
          // userCommentTile("Olawale",
          //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
          // const Divider(
          //   color: Colors.black,
          // ),
          // userCommentTile("Big Sam",
          //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
          // const Divider(
          //   color: Colors.black,
          // ),
          // userCommentTile("Michael",
          //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
        ],
      ),
    );
  }
}
