import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpcomingEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          upcomingEventCard('./assets/images/image 38.png'),
          const SizedBox(
            height: 15,
          ),
          upcomingEventCard('./assets/images/news2.png'),
        ],
      ),
    );
  }
}
