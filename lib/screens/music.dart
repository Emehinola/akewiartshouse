import 'package:flutter/material.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';

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
                              builder: (BuildContext context) =>
                                  MusicDisplay())),
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
            nowPlayingCard(),
            const SizedBox(height: 8.0),
            musicTile('./assets/images/music2.png'),
            const SizedBox(height: 8.0),
            musicTile('./assets/images/music1.png'),
            const SizedBox(height: 8.0),
            musicTile('./assets/images/music3.png'),
          ],
        ),
      ),
    );
  }
}
