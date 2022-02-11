import 'package:flutter/material.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class ArtWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: const Text(
          "Photography",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: searchContainer("Search for art works"),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PictureDisplay()));
            },
            child: artWorkCard(
                context,
                './assets/images/events.jpg',
                '"Lorem Ipsum is simply dummy text of the printing and typesetting industry."',
                'Chijioke',
                './assets/images/news1.png',
                './assets/images/news2.png',
                'Picture Series 1'),
          ),
          const SizedBox(
            height: 10,
          ),
          artWorkCard(
              context,
              './assets/images/news1.png',
              '"Lorem Ipsum is simply dummy text of the printing and typesetting industry."',
              'Sam',
              './assets/images/news3.png',
              './assets/images/news4.png',
              'Real photograph'),
          const SizedBox(height: 10.0),
          artWorkCard(
              context,
              './assets/images/news1.png',
              '"Lorem Ipsum is simply dummy text of the printing and typesetting industry."',
              'Sam',
              './assets/images/news3.png',
              './assets/images/news4.png',
              'Real photograph'),
          const SizedBox(height: 25.0),
        ]),
      ),
    );
  }
}
