import 'dart:convert';

import 'package:akewiartshouse/custom_widgets.dart';
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
  int comment;
  String? content;
  String? category;

  SinglePost(
      {Key? key,
      this.postId,
      this.title,
      this.content,
      this.author,
      required this.comment,
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
  TextEditingController commentCtrl = TextEditingController();
  bool loading = false;

  // deleting post
  Future deletePost(int postId) async {
    var request = await http.delete(
      Uri.parse(widget.category.toString().toLowerCase() == 'politics'
          ? '${EndPoint.baseUrl}/api/Politics/deletePoliticsById/$postId'
          : '${EndPoint.baseUrl}/api/Editorial/deleteEditorialById/$postId'),
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

  // create like
  Future createLike() async {
    var request = await http.post(
        Uri.parse(widget.category.toString().toLowerCase() == 'politics'
            ? '${EndPoint.baseUrl}/api/Politics/createPoliticsLike'
            : '${EndPoint.baseUrl}/api/Editorial/createEditorialLike'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'like': 1,
          widget.category.toString().toLowerCase() == 'politics'
              ? 'politicsId'
              : 'editorialId': widget.postId
        }));

    var response = json.decode(request.body.toString());

    if (response != null) {
      if (response['status'] == 'success') {
        commentCtrl.clear(); // clear the comment field data
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("post liked"),
        ));
        if (widget.category.toString().toLowerCase() == 'politics') {
          Database.box
              .put('politicsLike${widget.postId}', true)
              .then((value) => setState(() {}));
        } else {
          Database.box
              .put('editorialLike${widget.postId}', true)
              .then((value) => setState(() {}));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Unable to like post"),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Unable to like post"),
      ));
    }
  }

  // create comment
  Future createComment(String comment) async {
    var request = await http.post(
        Uri.parse(widget.category.toString().toLowerCase() == 'politics'
            ? '${EndPoint.baseUrl}/api/Politics/CreatePoliticsComment'
            : '${EndPoint.baseUrl}/api/Editorial/createEditorialComment'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'coments': comment,
          widget.category.toString().toLowerCase() == 'politics'
              ? 'politicsId'
              : 'editorialId': widget.postId
        }));

    try {
      var response = json.decode(request.body.toString());

      if (response != null) {
        if (response['status'] == 'success') {
          commentCtrl.clear(); // clear the comment field data
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("comment posted"),
          ));
          setState(() {
            loading = false;
            widget.comment += 1;
          });
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
    } catch (error) {
      setState(() {
        loading = false;
      });
    }
  }

  // get all comments
  Future getComments(int postId) async {
    var request = await http.get(
        Uri.parse(widget.category.toString().toLowerCase() == 'politics'
            ? '${EndPoint.baseUrl}/api/Politics/GetAllPoliticsComment/$postId'
            : '${EndPoint.baseUrl}/api/Editorial/getAllEditorialComments/$postId'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return request.body;
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
                          onPressed: () => createLike(),
                          icon: (widget.category.toString().toLowerCase() ==
                                      'politics'
                                  ? Database.box.get(
                                      'politicsLike${widget.postId}',
                                      defaultValue: false)
                                  : Database.box.get(
                                      'editorialLike${widget.postId}',
                                      defaultValue: false))
                              ? const Icon(CupertinoIcons.heart_fill,
                                  color: Colors.red)
                              : const Icon(CupertinoIcons.heart,
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
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Comments",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
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
                                result[index]['coments'] ?? 'None'),
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
