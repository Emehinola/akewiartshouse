import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/published_posts.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> screens = [UpcomingEvent(), PastEvent()];

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
          "My events",
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
                Expanded(
                  child: GestureDetector(
                    child: eventTypeCard(
                        "Upcoming events", _index == 0 ? true : false),
                    onTap: () {
                      setState(() {
                        _index = 0;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    child: eventTypeCard(
                        "Past events", _index == 1 ? true : false),
                    onTap: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
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
