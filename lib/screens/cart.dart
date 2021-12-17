import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.back)),
          title: const Text("Cart"),
          actions: [
            Row(
              children: [
                const Text(
                  "Clear Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                roundedContainer(IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const Cart())),
                    icon: const Icon(CupertinoIcons.trash)))
              ],
            )
          ]),
    );
  }
}
