import 'dart:convert';
import 'dart:math';

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
  PlayerState _playerState = PlayerState.STOPPED;
  bool playing = false;

  // player
  AudioPlayer? _player;
  AudioCache? cache;

  Duration currentPosition = Duration();
  Duration musicLength = Duration();

  // last played details
  String artistName = 'Unknown';
  String musicTitle = 'No playing music';


  // list of available music
  // all music
  List<dynamic> musicsUrl = [
    // empty @ default
  ];


  // get all music
  Future getMusic() async {
    var request = await http.get(
      Uri.parse('${EndPoint.baseUrl}/api/Music/getAllMusic'),
      headers: {
        'Authorization': 'Bearer ${Database.box.get('authorization')}',
        'Content-Type': 'application/json'
      },
    );

    // musicsUrl = json.decode(request.body.toString())['data'];
    // print(musicsUrl);
  // print(request.body);

    return request.body;
  }

  // slider
  Widget slider() {
    return Slider.adaptive(
      value: currentPosition.inMicroseconds.toDouble(),
      inactiveColor: Colors.grey[200],
      min: 0,
      max: musicLength.inMicroseconds.toDouble() + 1,
      activeColor: Colors.red,
      onChanged: (val) {
        seekToSec(val.round());
      },
    );
  }

  // slider 2
  // Widget slider() {
  //   return Slider.adaptive(
  //     value: currentPosition.inMicroseconds.toDouble(),
  //     inactiveColor: Colors.grey[200],
  //     min: 0,
  //     max: musicLength.inMicroseconds.toDouble() + 1,
  //     activeColor: Colors.red,
  //     onChanged: (val) {
  //       seekToSec(val.round());
  //     },
  //   );
  // }

  void seekToSec(int sec) async {
    Duration newPosition = Duration(seconds: sec);

    await _player!.seek(newPosition);
  }


  // changing current playing music
  void changeMusic(String musicUrl, String musicTitle, String artistName){
    setState(() {
      musicTitle = musicTitle;
      artistName = artistName;
    });
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player!.onDurationChanged.listen((value) {
      setState(() {
        musicLength = value;
      });
    });
    _player!.onAudioPositionChanged.listen((value) {
      setState(() {
        currentPosition = value;
      });
    });

    _player!.onPlayerError.listen((msg) {
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });

    _player!.onPlayerCompletion.listen((event) {
      PlayerState.COMPLETED;
      _player!.stop();
      setState(() {
        playing = false;
      });
    });

    playing = _playerState == PlayerState.PLAYING ? true : false;
    _player!.setUrl(musicUrl.toString());
  }

  @override
  void initState() {
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player!.onDurationChanged.listen((value) {
      setState(() {
        musicLength = value;
      });
    });
    _player!.onAudioPositionChanged.listen((value) {
      setState(() {
        currentPosition = value;
      });
    });

    _player!.onPlayerError.listen((msg) {
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });

    _player!.onPlayerCompletion.listen((event) {
      PlayerState.COMPLETED;
      _player!.stop();
      setState(() {
        playing = false;
      });
    });

    playing = _playerState == PlayerState.PLAYING ? true : false;
    // _player!.setUrl(musicsUrl[Random().nextInt(musicsUrl.length)]['musicPath']); // play the last played
    Database.box.get('lastPlayedMusic') != null ? _player!.setUrl(Database.box.get('lastPlayedMusic')) : '';
    super.initState();
  }


  @override
  void dispose() {
    _player!.dispose();
    super.dispose();
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
                      builder: (BuildContext context) => MusicUploadScreen())),
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
        child: FutureBuilder(
            future: getMusic(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
            try{
              return ListView(
                shrinkWrap: true,
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
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: jsonDecode(
                          snapshot.data.toString())['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) => MusicDisplay(
                                        title: jsonDecode(
                                            snapshot.data.toString())['data']
                                        [index]['musicTitle'],
                                        artist:
                                        jsonDecode(snapshot.data.toString())['data']
                                        [index]['artistName'],
                                        musicUrl:
                                        jsonDecode(snapshot.data.toString())['data']
                                        [index]['musicPath'],
                                        imageUrl:
                                        jsonDecode(snapshot.data.toString())['data']
                                        [index]['image']))),
                            child: musicListCard(jsonDecode(snapshot.data.toString())['data']
                            [index]['image'],
                                jsonDecode(snapshot.data.toString())['data']
                                [index]['musicTitle'] ?? '', jsonDecode(snapshot.data.toString())['data']
                                [index]['artistName'] ?? ''));
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
                      height: 120,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                                    Database.box.get('lastPlayedImage') == null ? Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              './assets/images/music2.png',
                                            ),
                                          )),
                                    ) : Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              Database.box.get('lastPlayedImage'),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(Database.box.get('lastPlayedTitle') ?? 'No last played',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          Text(Database.box.get('lastPlayedArtist') ?? 'None',
                                              style: const TextStyle(
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
                                      Database.box.get('lastPlayedMusic') != null ? IconButton(
                                        onPressed: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MusicDisplay(title: Database.box.get('lastPlayedTitle'),artist: Database.box.get('lastPlayedArtist'),musicUrl: Database.box.get('lastPlayedMusic'),imageUrl: Database.box.get('lastPlayedImage'),)));
                                          // if (playing) {
                                          //   var result = await _player!.pause();
                                          //   if (result == 1) {
                                          //     setState(() {
                                          //       playing = false;
                                          //     });
                                          //   }
                                          // } else {
                                          //   var result = await _player!.resume();
                                          //   if (result == 1) {
                                          //     setState(() {
                                          //       playing = true;
                                          //     });
                                          //   }
                                          // }
                                        },
                                        icon: Icon(
                                            playing
                                                ? CupertinoIcons.pause_solid
                                                : CupertinoIcons.play_arrow_solid,
                                            color: Colors.white),
                                      ) : const Icon(CupertinoIcons.play_arrow_solid, color: Colors.grey),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(CupertinoIcons.heart_fill,
                                            color: Colors.red),
                                      ),

                                    ],
                                  )
                                ]),
                            slider(),
                          ])),
                  const SizedBox(height: 5.0),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {

                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => MusicDisplay(
                                          title: jsonDecode(
                                              snapshot.data.toString())['data']
                                          [index]['musicTitle'] ?? 'No title',
                                          artist:
                                          jsonDecode(snapshot.data.toString())['data']
                                          [index]['artistName'] ?? 'Unknown',
                                          musicUrl:
                                          jsonDecode(snapshot.data.toString())['data']
                                          [index]['musicPath'],
                                          imageUrl:
                                          jsonDecode(snapshot.data.toString())['data']
                                          [index]['image'])));
                            },
                            child: Container(
                                height: 65,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 5.0,
                                          spreadRadius: 3.0,
                                          offset: Offset(1, 1),
                                          color: Colors.black12)
                                    ]),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Row(children: [

                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                jsonDecode(snapshot.data.toString())['data']
                                                   [index]['image'],
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(jsonDecode(snapshot.data.toString())['data']
                                   [index]['musicTitle'] ?? 'No title',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 12)),
                                          Text(jsonDecode(snapshot.data.toString())['data']
                                               [index]['artistName'] ?? 'Unknown',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontSize: 12)),
                                          // Text(duration,
                                          //     style: const TextStyle(
                                          //         fontWeight: FontWeight.bold,
                                          //         color: Colors.black,
                                          //         fontSize: 12)),
                                        ])
                                  ]),
                                  Row(
                                    children:  [
                                      InkWell(
                                        onTap: ()=>changeMusic(jsonDecode(snapshot.data.toString())['data']
                                        [index]['musicPath'], jsonDecode(snapshot.data.toString())['data']
                                        [index]['musicTile'], jsonDecode(snapshot.data.toString())['data']
                                        [index]['artistName']),
                                        child: const Icon(CupertinoIcons.play_arrow_solid,
                                            color: Colors.black, size: 18),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(CupertinoIcons.heart, color: Colors.black, size: 18),
                                      const SizedBox(width: 15),
                                      const Icon(CupertinoIcons.ellipsis_vertical,
                                          color: Colors.black, size: 18),
                                    ],
                                  )
                                ])),
                          );
                        },
                        itemCount:
                        jsonDecode(snapshot.data.toString())['data'].length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 0.0);
                        },
                      )



                  ),
                ],
              );
            }catch(error){

                return const Center(child: Text("Something went wrong. Try again"));
            }
          }
        ),
      ),
    );
  }
}
