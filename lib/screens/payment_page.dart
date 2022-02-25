import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class PaymentPage extends StatefulWidget {
  int numberOfItems;
  double totalCost;
  String email;
  String phone;
  String name;

  PaymentPage(
      {required this.numberOfItems,
      required this.totalCost,
      required this.email,
      required this.name,
      required this.phone});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back, color: Colors.black)),
        title: const Text("Checkout",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Secured Payment",
                  style: TextStyle(fontSize: 23),
                ),
                CreditCardForm(
                  cardNumber: "",
                  expiryDate: "",
                  cardHolderName: "",
                  cvvCode: "",
                  onCreditCardModelChange: (value) {},
                  formKey: formKey,
                  themeColor: Colors.yellow,
                ),
                const SizedBox(height: 20),
                Text("Number of items: ${widget.numberOfItems}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8.0),
                  height: 70,
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                NavigationScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        "Pay NGN ${widget.totalCost}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
