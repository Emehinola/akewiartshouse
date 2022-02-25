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
    print(Database.box.name);
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

    // add to cart
    Future addToCart(
        int bookId, int userId, int quantity, double unitPrice) async {
      var response = await http.post(
          Uri.parse(
              'http://placid-001-site50.itempurl.com/api/Cart/createCart'),
          headers: {
            'Authorization': 'Bearer ${Database.box.get('authorization')}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'bookId': bookId,
            'userId': userId,
            'unitPrice': unitPrice,
            'quantity': quantity
          }));

      return response.body;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back, color: Colors.black)),
        actions: [
          IconButton(
              icon: const Icon(
                CupertinoIcons.cart,
                color: Colors.black,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart())))
        ],
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
              print(snapshot.data);
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
                    height: 180,
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
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BookDetail(
                                          shares: "12",
                                          author: json
                                              .decode(snapshot.data.toString())[
                                                  'data'][index]['author']
                                              .toString(),
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
                            child: Container(
                              height: 140,
                              padding: const EdgeInsets.all(15.0),
                              width: double.infinity,
                              margin: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(json
                                                            .decode(snapshot
                                                                .data
                                                                .toString())[
                                                        'data'][index]['image']),
                                                    fit: BoxFit.cover)),
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  json.decode(snapshot.data
                                                          .toString())['data']
                                                      [index]['title'],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "By ${json.decode(snapshot.data.toString())['data'][index]['author']}"),
                                                Row(
                                                    children: List.generate(
                                                  int.parse(double.parse(json
                                                          .decode(
                                                              snapshot.data
                                                                  .toString())[
                                                              'data'][index]
                                                              ['rating']
                                                          .toString())
                                                      .toStringAsFixed(0)),
                                                  (index) => const Icon(
                                                    CupertinoIcons.star_fill,
                                                    color: Colors.black54,
                                                    size: 17,
                                                  ),
                                                )),
                                                Text(
                                                  "NGN ${json.decode(snapshot.data.toString())['data'][index]['amount']}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  addToCart(
                                                          json.decode(snapshot
                                                                      .data
                                                                      .toString())[
                                                                  'data'][index]
                                                              ['id'],
                                                          Database.box
                                                              .get('userId'),
                                                          1,
                                                          json.decode(snapshot
                                                                      .data
                                                                      .toString())[
                                                                  'data'][index]
                                                              ['amount'])
                                                      .then((value) {
                                                    if (value == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Unable to add item"),
                                                      ));
                                                    } else {
                                                      if (json.decode(value
                                                                  .toString())[
                                                              'status'] ==
                                                          'success') {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Item added to cart"),
                                                        ));
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              json.decode(value
                                                                      .toString())[
                                                                  'message']),
                                                        ));
                                                      }
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    height: 30,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.0)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Text("Add to basket",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12)),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Icon(
                                                          CupertinoIcons
                                                              .shopping_cart,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 1.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(1, 1),
                                        color: Colors.black12)
                                  ]),
                            ));
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

/*
bookSaleCard(
                              json.decode(snapshot.data.toString())['data']
                                  [index]['image'],
                              json.decode(snapshot.data.toString())['data']
                                  [index]['title'],
                              "By ${json.decode(snapshot.data.toString())['data'][index]['amount']}",
                              json
                                  .decode(snapshot.data.toString())['data']
                                      [index]['amount']
                                  .toString(),
                              json.decode(snapshot.data.toString())['data']
                                  [index]['rating']),
* */
