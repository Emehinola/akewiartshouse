import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PictureDisplay extends StatefulWidget {
  List<dynamic> images;
  String title;
  int photoId;

  PictureDisplay(
      {required this.images, required this.title, required this.photoId});

  @override
  State<PictureDisplay> createState() => _PictureDisplayState();
}

class _PictureDisplayState extends State<PictureDisplay> {
  Future deletePhoto(int photoId) async {
    var request = await http.delete(
        Uri.parse(
            '${EndPoint.baseUrl}/api/Photography/deletePhotographyById/$photoId'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    var response = json.decode(request.body);

    if (response != null) {
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Photos deleted")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unable to delete photos")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

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
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                ),
                onPressed: () => deletePhoto(widget.photoId))
          ],
        ),
        body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.images[index]['link']),
                        fit: BoxFit.cover)),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemCount: widget.images.length));
  }
}
