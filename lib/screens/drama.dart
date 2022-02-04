import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../custom_widgets.dart';
import 'screens.dart';

class Drama extends StatefulWidget {
  const Drama({Key? key}) : super(key: key);

  @override
  _DramaState createState() => _DramaState();
}

class _DramaState extends State<Drama> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text("Drama",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchContainer("Search for drama"),
              const SizedBox(
                height: 10,
              ),
              const Text("Recent Drama",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 170,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SinglePoet())),
                        child: columnCard("Holes", "Enoch Ojotisa",
                            './assets/images/image 37.png'),
                      ),
                      const SizedBox(width: 10.0),
                      columnCard("Holes", "Enoch Ojotisa",
                          './assets/images/image 38.png'),
                      const SizedBox(width: 10.0),
                      columnCard(
                          "Holes", "Enoch Ojotisa", './assets/images/bg.jpeg')
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Featured Drama",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold)),
              poemCard(),
              const SizedBox(
                height: 10,
              ),
              poemCard(),
              const SizedBox(height: 10),
              const SizedBox(
                height: 10,
              ),
              poemCard(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
