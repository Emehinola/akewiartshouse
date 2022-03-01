import 'package:flutter/material.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class Events extends StatefulWidget {
  int _index = 0;
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _events = [
      LiveEvent(),
      UpcomingEvent(),
      PastEvent(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          "Events",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black,
            )),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 35),
          child: Container(
            alignment: Alignment.topCenter,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: eventTypeCard("Live events", widget._index == 0),
                  onTap: () {
                    setState(() {
                      widget._index = 0;
                    });
                  },
                ),
                const SizedBox(
                  width: 13.0,
                ),
                GestureDetector(
                  child: eventTypeCard("Upcoming events", widget._index == 1),
                  onTap: () {
                    setState(() {
                      widget._index = 1;
                    });
                  },
                ),
                const SizedBox(
                  width: 13.0,
                ),
                GestureDetector(
                  child: eventTypeCard("Past events", widget._index == 2),
                  onTap: () {
                    setState(() {
                      widget._index = 2;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red,
      //   child: const Icon(CupertinoIcons.add, color: Colors.white),
      //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEvent())),
      // ),
      body: Builder(
        builder: (context) {
          return _events[widget._index];
        },
      ),
    );
  }
}
