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
    './assets/images/book_cover1.png',
    './assets/images/book_cover2.png',
    './assets/images/book_cover3.png',
    './assets/images/book_cover4.png'
  ];

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
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
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const BookDetail())),
                      child: productCard(book_images[index], "Enoch Ojotisa"));
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
            bookSaleCard(),
            const SizedBox(height: 8.0),
            bookSaleCard(),
            const SizedBox(height: 8.0),
            bookSaleCard()
          ],
        ),
      ),
    );
  }
}
