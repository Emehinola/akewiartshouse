import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: searchContainer("Search by title, organizer"),
            ),
            Row(
              children: [
                Expanded(child: pastEventCard()),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: pastEventCard()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
