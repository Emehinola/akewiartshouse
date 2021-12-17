import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens.dart';

class BookStore extends StatefulWidget {
  const BookStore({Key? key}) : super(key: key);

  @override
  _BookStoreState createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  List<String> book_images = [
    './assets/images/books.jpg',
    './assets/images/lit.jpg',
    './assets/images/painting.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.back)),
          title: const Text("Books Store"),
          actions: [
            Row(
              children: [
                const Text(
                  "Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const Cart())),
                      icon: const Icon(CupertinoIcons.cart)),
                )
              ],
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Soft Copy Version",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            SizedBox(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const BookDetail())),
                      child: productCard(book_images[index], "First Book"));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 5.0);
                },
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Audio Version",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            SizedBox(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return productCard("./assets/images/books.jpg", "Audio Book");
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 5.0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
