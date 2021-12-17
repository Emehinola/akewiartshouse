import 'package:flutter/material.dart';

class Poetry extends StatelessWidget {
  const Poetry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Poetry Category",
            style: TextStyle(fontSize: 23, letterSpacing: 3),
          ),
        ],
      ),
    );
  }
}
