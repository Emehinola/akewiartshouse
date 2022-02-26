import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
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
  bool playing = false;

  // player
  AudioPlayer? _player;
  AudioCache? cache;

  Duration currentPosition = Duration();
  Duration musicLength = Duration();

  // slider
  Widget slider() {
    return Slider.adaptive(
      value: currentPosition.inSeconds.toDouble(),
      inactiveColor: Colors.grey[200],
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

    // _player!.setUrl(widget.musicUrl.toString());
    super.initState();
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
                    children: [
                      const Icon(CupertinoIcons.shuffle,
                          color: Colors.redAccent, size: 30),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.backward_end,
                              color: Colors.red, size: 30),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              if (playing) {
                                _player!.pause();
                              } else {
                                // _player!.play(widget.musicUrl.toString(), isLocal: false, );
                                cache!.play('johnny.mp3');
                                // _player!.resume();
                              }

                              setState(() {
                                playing = !playing;
                              });
                            },
                            icon: Icon(
                                playing
                                    ? CupertinoIcons.pause_circle
                                    : CupertinoIcons.play_circle,
                                color: Colors.red,
                                size: 35),
                          ),
                          const SizedBox(width: 10),
                          const Icon(CupertinoIcons.forward_end,
                              color: Colors.redAccent, size: 30),
                        ],
                      ),
                      const Icon(CupertinoIcons.repeat,
                          color: Colors.red, size: 30)
                    ]),
              )
            ],
          ),
        ));
  }
}
