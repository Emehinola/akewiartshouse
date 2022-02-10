import 'package:flutter/material.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;
    List<Widget> _events = [
      LiveEvent(),
      UpcomingEvent(),
      const Scaffold(),
    ];

    @override
    void initState() {
      super.initState();
    }

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
                    child: eventTypeCard(
                        "Live events", _index == 0 ? true : false),
                    onTap: () {
                      setState(() {
                        _index = 0;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 13.0,
                  ),
                  GestureDetector(
                    child: eventTypeCard(
                        "Upcoming events", _index == 1 ? true : false),
                    onTap: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 13.0,
                  ),
                  GestureDetector(
                    child: eventTypeCard(
                        "Past events", _index == 2 ? true : false),
                    onTap: () {
                      setState(() {
                        _index = 2;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        body: _events[_index]);
  }
}
