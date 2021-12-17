import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class Editorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Editorial"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.chevron_back)),
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
                            builder: (BuildContext context) =>
                                const NavigationScreen())),
                    icon: const Icon(CupertinoIcons.add)),
              )
            ],
          )
        ],
      ),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        editorialCard(
            context,
            './assets/images/painting.jpg',
            'Africa Map Photography',
            'The content of the post goes here...',
            'Education',
            'John K'),
        const SizedBox(height: 25.0),
        editorialCard(
            context,
            './assets/images/events.jpg',
            'The content of the post goes here...',
            'Transportation',
            'Art name.',
            'Chijioke')
      ]),
    );
  }
}
