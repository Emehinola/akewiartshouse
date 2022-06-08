import 'dart:convert';
import 'dart:math';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  String? bookId;

  BookDetail({Key? key, this.bookId}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  // input controllers
  // TextEditingController emailCtrl = TextEditingController();
  // TextEditingController phone = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  // get book
  Future getBook() async {
    var request = await http.get(
        Uri.parse('${EndPoint.baseUrl}/api/Books/getBookById/${widget.bookId}'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return request.body;
  }

  // process payment
  processPayment(BuildContext context, String amount, String name) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: context,
          encryptionKey: "FLWSECK_TEST08e4a0b6e130",
          publicKey: "FLWPUBK_TEST-1e0d20b98a0a662d68abd35648c10ec3-X",
          currency: 'NGN',
          amount: amount,
          email: Database.box.get('email'),
          fullName: name,
          txRef:
              'txt-${Random(10000).nextInt(900000)}${DateTime.now().millisecond}-$amount',
          isDebugMode: true,
          phoneNumber: Database.box.get('phone'),
          acceptCardPayment: true,
          acceptUSSDPayment: true,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: false,
          acceptRwandaMoneyPayment: true,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false);

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      if (response.status == 'success') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Cart()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.message.toString())));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
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
                                size: 13,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 13,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 13,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.black54,
                                size: 13,
                              ),
                              Icon(
                                CupertinoIcons.star,
                                color: Colors.grey,
                                size: 13,
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
                              result['contentDesc'] ?? "No description",
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
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              content: SizedBox(
                                                height: 250,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    30.0),
                                                        decoration: const BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12.0))),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Payment",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                            IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  CupertinoIcons
                                                                      .xmark,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 50,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    nameCtrl,
                                                                decoration: InputDecoration(
                                                                    hintText:
                                                                        "Full name",
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0))),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Text(
                                                                "Number of items: 1",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            const SizedBox(
                                                                height: 20),
                                                            Container(
                                                              width: 340,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              height: 70,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  if (result[
                                                                          'amount'] >
                                                                      0) {
                                                                    processPayment(
                                                                        context,
                                                                        result['amount']
                                                                            .toString(),
                                                                        nameCtrl
                                                                            .text
                                                                            .toString());
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5.0,
                                                                      horizontal:
                                                                          20.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 45,
                                                                  child: Text(
                                                                    "Pay N${result['amount']}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
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
                                              ),
                                            ));
                                  },
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
