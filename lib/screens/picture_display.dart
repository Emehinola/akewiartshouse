import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.xmark,
              color: Colors.black,
            )),
        title: const Text(
          "Photo Series 1",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/images/news1.png'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/images/news2.png'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/images/news3.png'),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
