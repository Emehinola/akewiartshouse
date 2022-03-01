import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class MusicDisplay extends StatefulWidget {
  String? musicUrl;
  String? imageUrl;

  MusicDisplay({this.musicUrl, this.imageUrl});

  @override
  _MusicDisplayState createState() => _MusicDisplayState();
}

class _MusicDisplayState extends State<MusicDisplay> {
  // player controller
  PlayerState _playerState = PlayerState.STOPPED;
  bool playing = false;

  // player
  AudioPlayer? _player;
  AudioCache? cache;

  Duration currentPosition = Duration();
  Duration musicLength = Duration();

  // all music
  List<dynamic> musicsUrl = [
    // empty @ default
  ];

  // slider
  Widget slider() {
    return Slider.adaptive(
      value: currentPosition.inMicroseconds.toDouble(),
      inactiveColor: Colors.grey[200],
      min: 0,
      max: musicLength.inMicroseconds.toDouble(),
      activeColor: Colors.red,
      onChanged: (val) {
        seekToSec(val.round());
      },
    );
  }

  void seekToSec(int sec) async {
    Duration newPosition = Duration(seconds: sec);

    await _player!.seek(newPosition);
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
    super.initState();

    // cache!.load('johnny.mp3');

    _player!.setUrl(widget.musicUrl.toString());
    super.initState();
  }

  // get music
  Future getAllMusic() async {
    var request = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Music/getAllMusic'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    musicsUrl = json.decode(
        request.body)['data']; // list of all the links of available music

    return json.decode(request.body)['data'];
  }

  // change music
  void changeMusic(int currentMusicIndex, String type) async {
    getAllMusic().then((listOfMusicLink) {
      if (listOfMusicLink.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No music")));
      } else {
        try {
          setState(() {
            _player!.stop();
            playing = false;
            _player!.setUrl(type == 'forward'
                ? musicsUrl[currentMusicIndex + 1]['musicPath']
                : musicsUrl[currentMusicIndex - 1]['musicPath']);
            playing = true;
          });
        } catch (error) {
          setState(() {
            playing = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No music")));
        }
      }
    });
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
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 15.0),
              Container(
                  height: 230,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.imageUrl.toString())),
                    borderRadius: BorderRadius.circular(12.0),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Oremi",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
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
                height: 30,
              ),
              slider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                    "${currentPosition.inHours}:${currentPosition.inMinutes}:${currentPosition.inSeconds}",
                    style: const TextStyle(color: Colors.black)),
                Text(
                    "${musicLength.inHours}:${musicLength.inMinutes}:${musicLength.inSeconds}")
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.shuffle,
                            color: Colors.red, size: 30),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => changeMusic(1, 'reverse'),
                            icon: const Icon(CupertinoIcons.backward_end,
                                color: Colors.red, size: 30),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () async {
                              if (playing) {
                                var result = await _player!.pause();
                                if (result == 1) {
                                  setState(() {
                                    playing = false;
                                  });
                                }
                              } else {
                                var result = await _player!.resume();
                                if (result == 1) {
                                  setState(() {
                                    playing = true;
                                  });
                                }
                              }
                            },
                            icon: Icon(
                                playing
                                    ? CupertinoIcons.pause_circle
                                    : CupertinoIcons.play_circle,
                                color: Colors.red,
                                size: 35),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () => changeMusic(1, 'forward'),
                            icon: const Icon(CupertinoIcons.forward_end,
                                color: Colors.red, size: 30),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.repeat,
                            color: Colors.red, size: 30),
                      )
                    ]),
              )
            ],
          ),
        ));
  }
}
