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
                  Image.network(
                    widget.image.toString(),
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
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      content: SizedBox(
                                        height: 400,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  12.0))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text("Payment",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                        CupertinoIcons.xmark,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Card Holder's Name",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Card Number",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Expiration Date",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0))),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                                hintText: "CVV",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0))),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText: "Country",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Container(
                                                    width: 300,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    height: 70,
                                                    child: InkWell(
                                                      onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      contect) =>
                                                                  NavigationScreen())),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5.0,
                                                                horizontal:
                                                                    20.0),
                                                        alignment:
                                                            Alignment.center,
                                                        height: 45,
                                                        child: const Text(
                                                          "Pay Now",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: priceTag()),
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaymentPage())),
                          child: downloadTag())
                    ],
                  )
                ],
              )),
        ));
  }
}
