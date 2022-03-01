import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  String? bookId;

  BookDetail({Key? key, this.bookId}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  // get book
  Future getBook() async {
    var request = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Books/getBookById/${widget.bookId}'),
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
        ),
        body: FutureBuilder(
            future: getBook(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              try {
                var result = json.decode(snapshot.data.toString())['data'];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: result['image'],
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 17,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 17,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 17,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 17,
                              ),
                              Icon(
                                CupertinoIcons.star,
                                color: Colors.grey,
                                size: 17,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            result['title'] ?? "No title",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            result['author'] ?? "No author",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 13),
                          ),
                          Text(
                            "NGN ${result['amount']}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              result['description'] ?? "No description",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Available versions",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Audio version | E-book\n",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Cart())),
                                  child: priceTag()),
                              GestureDetector(
                                  onTap: () {}, child: downloadTag())
                            ],
                          )
                        ],
                      )),
                );
              } catch (error) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            }));
  }
}
