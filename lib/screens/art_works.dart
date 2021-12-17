import 'package:flutter/material.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class ArtWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.back)),
          title: const Text("Art Works"),
          actions: [
            Row(
              children: [
                const Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const Cart())),
                      icon: const Icon(CupertinoIcons.add)),
                )
              ],
            )
          ]),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        artWorkCard(context, './assets/images/painting.jpg',
            'Africa Map Photography', 'John K'),
        const SizedBox(height: 25.0),
        artWorkCard(
            context, './assets/images/events.jpg', 'Art name.', 'Chijioke')
      ]),
    );
  }
}
