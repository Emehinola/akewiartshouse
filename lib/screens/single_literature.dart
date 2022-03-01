import 'dart:convert';

import 'package:akewiartshouse/screens/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:akewiartshouse/backend/backend.dart';

class SinglePoet extends StatefulWidget {
  int? postId;
  String? image;
  String? author;
  String? title;
  String? datePosted;
  String? category;
  int? likes;
  int? shares;
  int? comment;
  String? content;

  SinglePoet(
      {Key? key,
      this.postId,
      this.title,
      this.content,
      this.author,
      this.comment,
      this.image,
      this.category,
      this.datePosted,
      this.likes,
      this.shares})
      : super(key: key);

  @override
  _SinglePoetState createState() => _SinglePoetState();
}

class _SinglePoetState extends State<SinglePoet> {
  // deleting post
  Future deletePost() async {
    var response = await http.delete(
      Uri.parse(
          'http://placid-001-site50.itempurl.com/api/Literature/deleteLiteratureById/${widget.postId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Database.box.get('authorization')}'
      },
    );

    return response.body;
  }

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Future getSingleItem() async {
      var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Literature/getLiteratureById/${widget.postId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Database.box.get('authorization')}'
        },
      );

      // print()

      return response.body;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                CupertinoIcons.xmark,
                color: Colors.black,
              )),
          actions: [
            InkWell(
              onTap: () {
                deletePost().then((response) {
                  if (json.decode(response.data.toString())['status'] ==
                      'success') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Post deleted successfully")));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Literature()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Unable to delete")));
                  }
                });
              },
              child: Row(
                children: const [
                  Text(
                    "Delete",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Icon(
                    CupertinoIcons.delete,
                    color: Colors.black,
                    size: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditLiterature(
                            litId: widget.postId!.toInt(),
                            image: widget.image,
                            title: widget.title,
                            content: widget.content,
                            category: widget.category,
                            author: widget.author,
                          ))),
              child: Row(
                children: const [
                  Text(
                    "Edit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    FontAwesomeIcons.edit,
                    color: Colors.black,
                    size: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(imageUrl: widget.image.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.title.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "By ${widget.author.toString()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    widget.datePosted.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.heart,
                              color: Colors.black)),
                      Text(widget.likes.toString(),
                          style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 15.0),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Colors.black54,
                            size: 19,
                          )),
                      Text(widget.shares.toString(),
                          style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 15.0),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chat_bubble,
                              color: Colors.black)),
                      Text(widget.comment.toString(),
                          style: const TextStyle(color: Colors.black54))
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.content.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
        ));
  }
}
