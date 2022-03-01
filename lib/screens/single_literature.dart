import 'dart:convert';

import 'package:akewiartshouse/custom_widgets.dart';
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
  //
  bool loading = false;

  TextEditingController commentCtrl = TextEditingController();

  // deleting post
  Future deletePost(int postId) async {
    var request = await http.delete(
      Uri.parse(
          'http://placid-001-site50.itempurl.com/api/Literature/deleteLiteratureById/${widget.postId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Database.box.get('authorization')}'
      },
    );

    var response = json.decode(request.body);

    if (response != null) {
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Post deleted"),
        ));
        Navigator.pop(context);
      }
    } else {
      //
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Unable to delete post"),
      ));
    }

    return response.body;
  }

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

  // create comment
  Future createComment(String comment) async {
    var request = await http.post(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Literature/createLiteratureComment'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'coments': comment, 'literatureId': widget.postId}));

    var response = json.decode(request.body.toString());

    if (response != null) {
      if (response['status'] == 'success') {
        commentCtrl.clear(); // clear the comment field data
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("comment posted"),
        ));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Unable to comment"),
        ));
      }
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Unable to comment"),
      ));
    }
  }

  // get all comments
  Future getComments(int postId) async {
    var request = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Literature/GetAllLiteratureComment/$postId'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return request.body;
  }

  GlobalKey<FormState> formKey = GlobalKey();
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
                deletePost(widget.postId!.toInt()).then((response) {
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
                            CupertinoIcons.chat_bubble,
                            color: Colors.black54,
                            size: 19,
                          )),
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
                    height: 30,
                  ),
                  FutureBuilder(
                    future: getComments(widget.postId!.toInt()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Text("Loading comments..."),
                        );
                      }
                      try {
                        var result =
                            json.decode(snapshot.data.toString())['data'];
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => userCommentTile(
                                result[index]['postedBy'] ?? 'anonymous',
                                result[index]['coments']),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: result.length);
                      } catch (error) {
                        return const Center(
                          child: Text("Unable to get comments"),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: commentCtrl,
                      decoration: InputDecoration(
                          hintText: 'Write comment here',
                          suffix: IconButton(
                            icon: Icon(loading
                                ? CupertinoIcons.dot_radiowaves_right
                                : CupertinoIcons.play_arrow_solid),
                            onPressed: () {
                              if (!loading && commentCtrl.text.isNotEmpty) {
                                setState(() {
                                  loading = true;
                                });
                                createComment(commentCtrl.text.toString());
                              }
                            },
                          ),
                          border: const UnderlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              )),
        ));
  }
}
