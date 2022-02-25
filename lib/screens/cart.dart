import 'dart:convert';
import 'dart:math';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/my_book.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutterwave/flutterwave.dart';

class Cart extends StatefulWidget {
  // getting cart items
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // total cost of items
  double amount = 0;
  int numberOfItems = 0;

  // input controllers
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  Future getCartItems() async {
    var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Cart/getAllCartByUserId/3'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Database.box.get('authorization')}'
        });

    return response.body;
  }

  Future getSingleBook(int bookId) async {
    var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Books/getBookById/$bookId'),
        headers: {'Authorization': '', 'Content-Type': ''});

    var result = json.decode(response.body);

    return result;
  }

  Future deleteCart(int cartId) async {
    // deleting cart
    var deleteRequest = await http.delete(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Cart/deleteCartById/$cartId'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return deleteRequest.body;
  }

  // process payment
  processPayment(BuildContext context, String amount, String email,
      String phone, String name) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: context,
          encryptionKey: "FLWSECK_TEST08e4a0b6e130",
          publicKey: "FLWPUBK_TEST-1e0d20b98a0a662d68abd35648c10ec3-X",
          currency: 'NGN',
          amount: amount,
          email: email,
          fullName: name,
          txRef:
              'txt-${Random(10000).nextInt(900000)}${DateTime.now().millisecond}-$amount',
          isDebugMode: true,
          phoneNumber: phone,
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
      print("response: ${response.data!.id}");
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

  @override
  Widget build(BuildContext context) {
    numberOfItems = 0;
    amount = 0.0;

    TextEditingController nameCtrl = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                )),
            title: const Text("Book Cart",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            actions: [
              Row(
                children: [
                  const Text(
                    "Clear Cart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  roundedContainer(IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Cart())),
                      icon: const Icon(CupertinoIcons.trash)))
                ],
              )
            ]),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            label: const Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        content: SizedBox(
                          height: 372,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Payment",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      IconButton(
                                          icon: const Icon(
                                            CupertinoIcons.xmark,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: nameCtrl,
                                          decoration: InputDecoration(
                                              hintText: "Full name",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0))),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: emailCtrl,
                                          decoration: InputDecoration(
                                              hintText: "Email",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0))),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: phone,
                                          decoration: InputDecoration(
                                              hintText: "Phone number",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0))),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Number of items: $numberOfItems",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: 340,
                                        padding: const EdgeInsets.all(8.0),
                                        height: 70,
                                        child: InkWell(
                                          onTap: () {
                                            if (amount > 0) {
                                              processPayment(
                                                  context,
                                                  amount.toString(),
                                                  emailCtrl.text.toString(),
                                                  phone.text.toString(),
                                                  nameCtrl.text.toString());
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 20.0),
                                            alignment: Alignment.center,
                                            height: 45,
                                            child: Text(
                                              "Pay N$amount",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
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
            }),
        body: FutureBuilder(
            future: getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (jsonDecode(snapshot.data.toString())['data'].length < 1) {
                return const Center(child: Text("No items found here"));
              }
              return Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: GridView.builder(
                    itemCount:
                        jsonDecode(snapshot.data.toString())['data'].length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      // computing the amount and total quantity of items
                      numberOfItems += int.parse(
                          jsonDecode(snapshot.data.toString())['data'][index]
                                  ['quantity']
                              .toString());
                      amount += jsonDecode(snapshot.data.toString())['data']
                          [index]['totalPrice'];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyBook(
                                      book_id: 20,
                                      title: "Commoner's cry",
                                      image:
                                          'https://i.ibb.co/R6pg49X/koins-full-logo.png',
                                      shares: '320',
                                      likes: '32',
                                      author: 'Samuel',
                                      version: 'Audio',
                                      comments: '231',
                                      amount: '2,394',
                                      description:
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                                    ))),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            './assets/images/book_cover1.png'),
                                        fit: BoxFit.cover)),
                              )),
                              const Text(
                                "Commoner's cry",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  children: List.generate(
                                5,
                                (index) => const Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.black54,
                                  size: 13,
                                ),
                              )),
                              Text(
                                "N ${jsonDecode(snapshot.data.toString())['data'][index]['totalPrice']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Quantity: ${jsonDecode(snapshot.data.toString())['data'][index]['quantity']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // IconButton(
                                  //     onPressed: () {},
                                  //     icon: const Icon(
                                  //         CupertinoIcons.minus_circle_fill)),
                                  // IconButton(
                                  //     onPressed: () {},
                                  //     icon: const Icon(
                                  //         CupertinoIcons.plus_circle_fill)),
                                  IconButton(
                                      onPressed: () {
                                        deleteCart(jsonDecode(snapshot.data
                                                    .toString())['data'][index]
                                                ['id'])
                                            .then((value) {
                                          if (json.decode(
                                                  value.toString())['status'] ==
                                              'success') {
                                            setState(() {});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Item removed fom cart")));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(json.decode(
                                                            value.toString())[
                                                        'message'])));
                                          }
                                        });
                                      },
                                      icon: const Icon(CupertinoIcons.delete))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
}
