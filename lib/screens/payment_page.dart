import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back)),
        title: const Text("Checkout"),
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
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8.0),
                  height: 70,
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext contect) =>
                                NavigationScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      alignment: Alignment.center,
                      height: 50,
                      child: const Text(
                        "Pay NGN107,000.0",
                        style: TextStyle(
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
