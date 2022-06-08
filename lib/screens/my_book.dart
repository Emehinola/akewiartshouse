import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/books_store.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBook extends StatefulWidget {
  String? image;
  int? book_id;
  String? title;
  String? author;
  String? amount;
  String? likes;
  String? shares;
  String? comments;
  String? description;
  String? version;

  MyBook(
      {Key? key,
      this.author,
      this.book_id,
      this.shares,
      this.likes,
      this.title,
      this.image,
      this.amount,
      this.comments,
      this.description,
      this.version})
      : super(key: key);

  @override
  _MyBookState createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  // delete book
  Future deleteBook() async {
    var response = await http.delete(
        Uri.parse(
            '${EndPoint.baseUrl}/api/Books/deleteBookById/${widget.book_id}'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });
    var result = json.decode(response.body.toString());

    try {
      if (result.data['data']['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Book deleted successfully")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unable to delete book")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookStore()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Unable to delete book")));
    }
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
              onTap: () => deleteBook(),
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
                  context, MaterialPageRoute(builder: (context) => EditBook())),
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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.image.toString(),
                    height: 200,
                  ),
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
                    widget.author.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "NGN ${widget.amount}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.description.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text(
                            "Available versions",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Audio version | E-book\n",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            "Downloads",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "307",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ));
  }
}
