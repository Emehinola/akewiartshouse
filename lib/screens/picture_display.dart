import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureDisplay extends StatelessWidget {
  List<dynamic> images;
  String title;

  PictureDisplay({required this.images, required this.title});

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
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(images[index]['link']),
                        fit: BoxFit.cover)),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemCount: images.length));
  }
}
