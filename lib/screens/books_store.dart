import 'dart:convert';

import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens.dart';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:http/http.dart' as http;

class BookStore extends StatefulWidget {
  const BookStore({Key? key}) : super(key: key);

  @override
  _BookStoreState createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  List<String> book_images = [
    './assets/images/book_cover1.png',
    './assets/images/book_cover2.png',
    './assets/images/book_cover3.png',
    './assets/images/book_cover4.png'
  ];

  @override
  Widget build(BuildContext context) {
    // getting books
    Future getBooks() async {
      var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Books/getAllBooks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Database.box.get('authorization')}'
        },
      );

      return response.body;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back, color: Colors.black)),
        title: const Text("Bookstore", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 0.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: FutureBuilder(
            future: getBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  searchContainer("Search for books"),
                  const SizedBox(height: 5),
                  const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Most recent books",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      )),
                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          json.decode(snapshot.data.toString())['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        BookDetail(
                                          shares: "12",
                                          author: "Enoch Ojotisa",
                                          amount: json
                                              .decode(snapshot.data.toString())[
                                                  'data'][index]['amount']
                                              .toString(),
                                          comments: "34",
                                          description: json.decode(snapshot.data
                                                  .toString())['data'][index]
                                              ['contentDesc'],
                                          version: "Hard copy",
                                          image: json.decode(snapshot.data
                                                  .toString())['data'][index]
                                              ['image'],
                                          likes: "34",
                                          title: json.decode(snapshot.data
                                                  .toString())['data'][index]
                                              ['title'],
                                        ))),
                            child: productCard(
                                json.decode(snapshot.data.toString())['data']
                                    [index]['image'],
                                json.decode(snapshot.data.toString())['data']
                                    [index]['title'],
                                "Enoch Ojotisa"));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Featured books",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      )),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return bookSaleCard(
                            json.decode(snapshot.data.toString())['data'][index]
                                ['image'],
                            json.decode(snapshot.data.toString())['data'][index]
                                ['title'],
                            "By Enouch Ojotisa",
                            json
                                .decode(snapshot.data.toString())['data'][index]
                                    ['amount']
                                .toString());
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount:
                          json.decode(snapshot.data.toString())['data'].length)
                ],
              );
            }),
      ),
    );
  }
}
