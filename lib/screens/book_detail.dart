import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:drop_cap_text/drop_cap_text.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.back)),
            title: const Text("Book Name"),
            actions: [
              Row(
                children: [
                  const Text(
                    "Remove from Cart",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  roundedContainer(IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const NavigationScreen())),
                      icon: const Icon(CupertinoIcons.trash)))
                ],
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const Text(
                "Book title here",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const Text(
                "writeen by Author",
                style: TextStyle(),
              ),
              const Padding(padding: EdgeInsets.all(20.0)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('./assets/images/books.jpg')),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Chapter One (1)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              DropCapText(
                """Weird feeling,
feel like I was wired through,
oh another empty soul.

You wake up to a new day,
yea, the creator, God, you must thank,
still you are moody.

You wake up to a new day,
yea, the creator, God, you must thank,
still you are moody.
""",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  priceTag("50"),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PaymentPage())),
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.lightBlue,
                          ),
                          child: const Text("Buy Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))))
                ],
              )
            ],
          ),
        ));
  }
}
