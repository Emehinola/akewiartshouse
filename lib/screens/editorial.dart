import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets.dart';
import 'screens.dart';

class Editorial extends StatefulWidget {
  const Editorial({Key? key}) : super(key: key);

  @override
  _EditorialState createState() => _EditorialState();
}

class _EditorialState extends State<Editorial> {
  // getting politics articles
  Future getPolitics() async {
    var response = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Editorial/getAllEditorial'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Database.box.get('authorization')}'
        });

    return response.body;
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
        title: const Text("Editorial",
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
                                            likes: 12,
                                            postId: result[index]['id'],
                                            shares: 23,
                                            category: 'editorial',
                                            datePosted: result[index]['date'],
                                            comment: 34,
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
                                  result[0]['postedby'],
                                  result[0]['image']),
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
                            return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SinglePost(
                                              title: result[index]['title'],
                                              author: result[index]['postedby'],
                                              likes: 12,
                                              postId: result[index]['id'],
                                              shares: 23,
                                              datePosted: result[index]['date'],
                                              comment: 34,
                                              image: result[index]['image'],
                                              content: result[index]
                                                  ['description'],
                                            ))),
                                child: poemCard(
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
