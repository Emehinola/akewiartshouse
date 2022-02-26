import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookDetail extends StatefulWidget {
  String? image;
  String? title;
  String? author;
  String? amount;
  String? likes;
  String? shares;
  String? comments;
  String? description;
  String? version;

  BookDetail(
      {Key? key,
      this.author,
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
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
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
                            FontAwesomeIcons.shareAlt,
                            color: Colors.black54,
                            size: 19,
                          )),
                      Text(widget.shares.toString(),
                          style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 15.0),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chat_bubble,
                              color: Colors.black)),
                      Text(widget.comments.toString(),
                          style: const TextStyle(color: Colors.black54))
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available versions",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cart())),
                          child: priceTag()),
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaymentPage(
                                          numberOfItems: 3,
                                          totalCost: 3299,
                                          email: '',
                                          phone: '',
                                          name: ''))),
                          child: downloadTag())
                    ],
                  )
                ],
              )),
        ));
  }
}
