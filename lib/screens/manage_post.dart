import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/published_posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagePost extends StatefulWidget {
  @override
  _ManagePostState createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> {
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> screens = [PublishedPost(), Scaffold(), Scaffold(), Scaffold()];

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
        title: const Text(
          "Manage posts",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: eventTypeCard("Published", _index == 0 ? true : false),
                  onTap: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                ),
                GestureDetector(
                  child: eventTypeCard("Drafts", _index == 1 ? true : false),
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                ),
                GestureDetector(
                  child: eventTypeCard("Pending", _index == 2 ? true : false),
                  onTap: () {
                    setState(() {
                      _index = 2;
                    });
                  },
                ),
                GestureDetector(
                  child: eventTypeCard("Declined", _index == 3 ? true : false),
                  onTap: () {
                    setState(() {
                      _index = 3;
                    });
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: screens[_index],
            )
          ],
        ),
      ),
    );
  }
}
