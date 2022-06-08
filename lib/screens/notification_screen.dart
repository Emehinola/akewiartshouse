import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatelessWidget {
  // get all notifications
  Future getNotifications() async {
    var request = await http.get(Uri.parse('uri'), headers: {
      'Authorization': 'Bearer ${Database.box.get('authorization')}',
      'Content-Type': 'application/json'
    });

    return request.body;
  }

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
        title: const Text("Notifications",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder(
          future: getNotifications(),
          builder: (context, snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: Text("No notification found"),
              );
            } catch (error) {
              return const Center(
                child: Text("Error fetching notifications"),
              );
            }
          }),
    );
  }
}
