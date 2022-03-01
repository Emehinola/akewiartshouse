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
  TextEditingController commentCtrl = TextEditingController();
  bool loading = false;
  static List<dynamic> commentLikes = ['0', '0'];

  // deleting post
  Future deletePost(int postId) async {
    var request = await http.delete(
      Uri.parse(widget.category.toString().toLowerCase() == 'politics'
          ? 'http://placid-001-site50.itempurl.com/api/Politics/deletePoliticsById/$postId'
          : 'http://placid-001-site50.itempurl.com/api/Editorial/deleteEditorialById/$postId'),
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

  // get total number of likes
  Future getLikes(int postId) async {
    var request = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Politics/GetPoliticsCommentLike/$postId'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    var response = json.decode(request.body)['data'];
    print(response);
    if (response != null) {
      commentLikes[0] = response['totalComments'].toString();
      commentLikes[1] = response['totalLikes'].toString();
    } else {
      commentLikes[0] = '0';
      commentLikes[1] = '0';
    }
    print(commentLikes);
  }

  // create comment
  Future createComment(String comment) async {
    var request = await http.post(
        Uri.parse(widget.category.toString().toLowerCase() == 'politics'
            ? 'http://placid-001-site50.itempurl.com/api/Politics/CreatePoliticsComment'
            : 'http://placid-001-site50.itempurl.com/api/Editorial/createEditorialComment'),
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

  @override
  Widget build(BuildContext context) {
    getLikes(widget.postId!.toInt());
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
                      Text(commentLikes[1],
                          style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 15.0),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.chat_bubble,
                            color: Colors.black54,
                            size: 19,
                          )),
                      Text(commentLikes[0],
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
