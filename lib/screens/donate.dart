import 'dart:convert';
import 'dart:math';
import 'package:akewiartshouse/screens/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  // text controllers
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController amount = TextEditingController();

  // process payment
  processPayment(
      BuildContext context,
      String amount,
      String email,
      String phone,
      String name,
      String address,
      String city,
      String country) async {
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
              'txt-donation-${Random(10000).nextInt(900000)}${DateTime.now().millisecond}-$amount',
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
        // record donation to database
        registerDonation(name, email, phone, address, city, country);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.message.toString())));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future registerDonation(String name, String email, String phone,
      String address, String city, String country) async {
    try {
      var request = await http.post(
          Uri.parse(
              'http://placid-001-site50.itempurl.com/api/Donation/createDonation'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'fullname': name,
            'emailaddress': email,
            'phonenumber': phone,
            'address': address,
            'city': city,
            'country': country
          }));

      if (jsonDecode(request.body.toString())['status'] == 'success') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Payment not successful"),
        ));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Donate",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: ListView(
          children: [
            const Text(
              "Donate to Akewiartshouse limited",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Bank: Zenith Bank\nAccount Number: 2089497582\nAccount Name: OJOTISA ENOCH AANUOLUWAPO",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const Divider(
              height: 50,
              color: Colors.grey,
            ),
            const Text(
              "Donate Here",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 45,
              child: TextField(
                controller: amount,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                decoration: InputDecoration(
                    hintText: "Amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: "Full name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: "Email address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                controller: phone,
                decoration: InputDecoration(
                    hintText: "Phone number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: city,
                      decoration: InputDecoration(
                          hintText: "City",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
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
                      controller: country,
                      decoration: InputDecoration(
                          hintText: "Country",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () => processPayment(
                  context,
                  amount.text.toString(),
                  email.text.toString(),
                  phone.text.toString(),
                  name.text.toString(),
                  address.text.toString(),
                  city.text.toString(),
                  country.text.toString()),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                child: const Text(
                  "Donate now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
