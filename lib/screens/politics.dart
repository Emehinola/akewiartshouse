import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets.dart';
import 'screens.dart';

class Politics extends StatefulWidget {
  const Politics({Key? key}) : super(key: key);

  @override
  _PoliticsState createState() => _PoliticsState();
}

class _PoliticsState extends State<Politics> {
  // comment/like list
  List<Map<String, dynamic>> commentLike = [];
  // getting politics articles
  Future getPolitics() async {
    var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Politics/getAllPolitics'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Database.box.get('authorization')}'
        });

    return response.body;
  }

  // get total number of likes
  Future getLikes(int postId) async {
    var request = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Politics/GetPoliticsCommentLike/$postId'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    var response = json.decode(request.body)['data'];
    print(response);
    if (response != null) {
      commentLike.add({
        'comments': response['totalComments'],
        'likes': response['totalLikes']
      });
    } else {
      commentLike.add({'comments': '0', 'likes': '0'});
    }
    print(commentLike);
  }

  // get number of comments
  // Future getNumberOfComment() {}

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
        title: const Text("Politics",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreatePost())),
        backgroundColor: Colors.black,
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FutureBuilder(
              future: getPolitics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  var result = json.decode(snapshot.data.toString())[
                      'data']; // returned data in json format

                  if (result.length == 0) {
                    // for empty post
                    return const Center(
                      child: Text("No post here"),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchContainer("Search for title, writer"),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Recent posts",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 170,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: result.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10.0,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SinglePost(
                                            title: result[index]['title'],
                                            author: result[index]['postedby'],
                                            likes: result[index]['totalLikes'],
                                            postId: result[index]['id'],
                                            shares: 23,
                                            datePosted: result[index]['date'],
                                            comment: result[index]
                                                ['totalComments'],
                                            image: result[index]['image'],
                                            content: result[index]
                                                ['description'],
                                          ))),
                              child: columnCard(
                                  result[index]['title'].toString().length <= 10
                                      ? result[index]['title'].toString()
                                      : result[index]['title']
                                          .toString()
                                          .substring(0, 10),
                                  result[index]['postedby'],
                                  result[index]['image']),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Featured posts",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold)),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            // getLikes(result[index]['id']);
                            return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SinglePost(
                                              title: result[index]['title'],
                                              author: result[index]['postedby'],
                                              likes: result[index]
                                                      ['totalLikes'] ??
                                                  0,
                                              postId: result[index]['id'],
                                              category: 'politics',
                                              shares: 23,
                                              datePosted: result[index]['date'],
                                              comment: result[index]
                                                      ['totalCommments'] ??
                                                  0,
                                              image: result[index]['image'],
                                              content: result[index]
                                                  ['description'],
                                            ))),
                                child: poemCard(
                                    result[index]['totalComments'] ?? '0',
                                    result[index]['totalLikes'] ?? '0',
                                    result[index]['title'],
                                    result[index]['postedby'],
                                    result[index]['date'],
                                    result[index]['image']));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10.0,
                            );
                          },
                          itemCount: result.length)
                    ],
                  );
                }
                return const Center(
                  child: Text('Something went wrong'),
                );
              }),
        ),
      ),
    );
  }
}
