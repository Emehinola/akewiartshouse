import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DraftPost extends StatelessWidget {
  // get user posts
  Future getPolitics() async {
    var requestPolitics = await http.get(
        Uri.parse(
            '${EndPoint.baseUrl}/api/Politics/getAllPoliticsByUserId/${Database.box.get('userId')}'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return requestPolitics.body;
  }

  // get user posts
  Future getEditorial() async {
    var requestEditorial = await http.get(
        Uri.parse(
            '${EndPoint.baseUrl}/api/Editorial/getAllEditorialByUserId/${Database.box.get('userId')}'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return requestEditorial.body;
  }

  // get user posts
  Future getLiterature() async {
    var requestLiterature = await http.get(
        Uri.parse(
            '${EndPoint.baseUrl}/api/Literature/getAllLiteratureByUserId/${Database.box.get('userId')}'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return requestLiterature.body;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Politics posts",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        FutureBuilder(
            future: getPolitics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              try {
                var result = json.decode(snapshot.data.toString())['data'];
                return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: result.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SinglePost(
                                      title: result[index]['title'],
                                      content: result[index]['description'],
                                      image: result[index]['image'],
                                      category: 'politics',
                                      postId: result[index]['id'],
                                      author: result[index]['postedBy'],
                                      comment: result[index]['totalComments'],
                                      datePosted: result[index]['date'],
                                      likes: result[index]['totalLikes'],
                                      shares: 21,
                                    ))),
                        child: publishedPostCard("Politics",
                            result[index]['image'], result[index]['title']),
                      );
                    });
              } catch (error) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            }),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Editorial posts",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        FutureBuilder(
            future: getEditorial(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              try {
                var result = json.decode(snapshot.data.toString())['data'];
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: result.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SinglePost(
                                      title: result[index]['title'],
                                      content: result[index]['description'],
                                      image: result[index]['image'],
                                      category: 'editorial',
                                      postId: result[index]['id'],
                                      author: result[index]['postedBy'],
                                      comment: result[index]['totalComments'],
                                      datePosted: result[index]['date'],
                                      likes: result[index]['totalLikes'],
                                      shares: 21,
                                    ))),
                        child: publishedPostCard("Editorial",
                            result[index]['image'], result[index]['title']),
                      );
                    });
              } catch (error) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            }),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Literature posts",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        FutureBuilder(
            future: getLiterature(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              try {
                var result = json.decode(snapshot.data.toString())['data'];
                return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: result.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SinglePost(
                                      title: result[index]['title'],
                                      content: result[index]['contDesc'],
                                      image: result[index]['image'],
                                      category: 'poetry',
                                      postId: result[index]['id'],
                                      author: result[index]['postedBy'],
                                      comment: result[index]['totalComments'],
                                      datePosted: result[index]['date'],
                                      likes: result[index]['totalLikes'],
                                      shares: 21,
                                    ))),
                        child: publishedPostCard("Literature",
                            result[index]['image'], result[index]['title']),
                      );
                    });
              } catch (error) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            }),
        const SizedBox(
          height: 50,
          child: Text(""),
        ),
      ],
    );
  }
}
