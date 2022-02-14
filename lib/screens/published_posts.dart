import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PublishedPost extends StatelessWidget {
  // get my posts
  Future getPosts() async {
    var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Literature/getAllLiterature'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return publishedPostCard("Politics");
        });
  }
}
