import 'dart:convert';

import 'package:akewiartshouse/screens/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:akewiartshouse/backend/backend.dart';

class SinglePost extends StatefulWidget {
  int? postId;
  String? image;
  String? author;
  String? title;
  String? datePosted;
  int? likes;
  int? shares;
  int? comment;
  String? content;
  String? category;

  SinglePost(
      {Key? key,
      this.postId,
      this.title,
      this.content,
      this.author,
      this.comment,
      this.category,
      this.image,
      this.datePosted,
      this.likes,
      this.shares})
      : super(key: key);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  GlobalKey<FormState> formKey = GlobalKey();

  Future deletePost() async {
    var response = await http.delete(
      Uri.parse(widget.category == 'politics'
          ? 'http://placid-001-site50.itempurl.com/api/Politics/deletePoliticsById/${widget.postId}'
          : 'http://placid-001-site50.itempurl.com/api/Editorial/deleteEditorialById/${widget.postId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Database.box.get('authorization')}'
      },
    );

    // print()

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
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
                        MaterialPageRoute(builder: (context) => Politics()));
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
                      builder: (context) => EditPost(
                            postId: widget.postId!.toInt(),
                            content: widget.content,
                            title: widget.title,
                            author: widget.author,
                            category: widget.category,
                            image: widget.image,
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
