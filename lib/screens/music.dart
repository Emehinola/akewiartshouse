import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  List<String> book_images = [
    './assets/images/music1.png',
    './assets/images/music2.png',
    './assets/images/music3.png',
    './assets/images/music1.png'
  ];

  // player controller
  bool playing = false;

  // player
  AudioPlayer? _player;
  AudioCache? cache;

  Duration currentPosition = Duration();
  Duration musicLength = Duration();

  // get all music
  Future getMusic() async {
    var request = await http.get(
      Uri.parse('http://placid-001-site50.itempurl.com/api/Music/getAllMusic'),
      headers: {
        'Authorization': 'Bearer ${Database.box.get('authorization')}',
        'Content-Type': 'application/json'
      },
    );

    return request.body;
  }

  // slider
  Widget slider() {
    return Slider.adaptive(
      value: currentPosition.inSeconds.toDouble(),
      inactiveColor: Colors.grey[100],
      max: musicLength.inSeconds.toDouble(),
      activeColor: Colors.red,
      onChanged: (val) {
        seekToSec(val.toInt());
      },
    );
  }

  void seekToSec(int sec) {
    Duration newPosition = Duration(seconds: sec);
    _player!.seek(newPosition);
  }

  @override
  void initState() {
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player!.getDuration().then((duration) {
      setState(() {
        musicLength = Duration(seconds: duration);
      });
    });
    _player!.onAudioPositionChanged.length.then((value) {
      setState(() {
        currentPosition = Duration(seconds: value);
      });
    });
    // _player!.getCurrentPosition().then((position) {
    //   setState(() {
    //     currentPosition = Duration(seconds: position);
    //   });
    // });

    cache!.load('johnny.mp3');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Music",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.chevron_back, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const NavigationScreen())),
              icon: const Icon(
                CupertinoIcons.add_circled_solid,
                color: Colors.blueGrey,
                size: 35,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 0.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            searchContainer("Search for song title, artist"),
            const SizedBox(height: 5),
            const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Popular music",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                )),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) => MusicDisplay(
                                    musicUrl:
                                        'http://placid-001-site50.itempurl.com/MusicPathFile/8a42bbe0[Waploaded]Johnny_Drille_-_In_Christ_Alone_(My_hope_is_found)-1556236683.mp3',
                                    imageUrl:
                                        'http://placid-001-site50.itempurl.com/MusicImages/dcfea5c6d1.png',
                                  ))),
                      child: musicListCard(book_images[index],
                          "Commoner's Speech", "Enoch Ojotisa"));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox.shrink();
                },
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: Text(
                  "Featured music",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                )),
            Container(
                height: 130,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset('./assets/images/music2.png',
                                  height: 55),
                              const SizedBox(width: 5),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Oremi",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    const Text("Angelique kodja",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Text(
                                        "${musicLength.inMinutes}:${musicLength.inSeconds}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ])
                            ]),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (playing) {
                                      _player!.pause();
                                    } else {
                                      cache!.play('johnny.mp3');
                                    }

                                    setState(() {
                                      playing = !playing;
                                    });
                                  },
                                  icon: Icon(
                                      playing
                                          ? CupertinoIcons.pause_solid
                                          : CupertinoIcons.play_arrow_solid,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 15),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(CupertinoIcons.heart_fill,
                                      color: Colors.red),
                                ),
                                const SizedBox(width: 15),
                                const Icon(CupertinoIcons.ellipsis_vertical,
                                    color: Colors.white),
                              ],
                            )
                          ]),
                      slider(),
                    ])),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: getMusic(),
                  builder: (context, snapshot) {
                    var result = jsonDecode(snapshot.data.toString())['data'];

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: Colors.black,
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => MusicDisplay(
                                      musicUrl: jsonDecode(
                                              snapshot.data.toString())['data']
                                          [index]['musicPath'],
                                      imageUrl: jsonDecode(
                                              snapshot.data.toString())['data']
                                          [index]['image']))),
                          child: musicTile(
                              jsonDecode(snapshot.data.toString())['data']
                                  [index]['image'],
                              'Nice music',
                              'Samuel',
                              '2:32'),
                        );
                      },
                      itemCount:
                          jsonDecode(snapshot.data.toString())['data'].length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8.0);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
