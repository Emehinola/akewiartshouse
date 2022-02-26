import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets.dart';
import 'screens.dart';

class Literature extends StatefulWidget {
  const Literature({Key? key}) : super(key: key);

  @override
  _LieratureState createState() => _LieratureState();
}

class _LieratureState extends State<Literature> {
  // loading data
  Future getPoetry() async {
    var response = await http.get(
      Uri.parse(
          'http://placid-001-site50.itempurl.com/api/Literature/getAllLiterature'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Database.box.get('authorization')}'
      },
    );

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
        title: const Text("Poetry",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateLiterature())),
        backgroundColor: Colors.black,
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder(
              future: getPoetry(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchContainer("Search for poetry"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Recent Poems",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 170,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SinglePoet(
                                              shares: 87,
                                              image: json.decode(snapshot.data
                                                      .toString())['data'][0]
                                                  ['image'],
                                              title: json.decode(snapshot.data
                                                      .toString())['data'][0]
                                                  ['title'],
                                              author: json.decode(snapshot.data
                                                      .toString())['data'][0]
                                                  ['postBy'],
                                              comment: 90,
                                              content: json.decode(snapshot.data
                                                      .toString())['data'][0]
                                                  ['contDesc'],
                                              datePosted: json.decode(snapshot
                                                      .data
                                                      .toString())['data'][0]
                                                  ['date'],
                                              likes: 78,
                                              poetId: json.decode(snapshot.data
                                                  .toString())['data'][0]['id'],
                                            ))),
                                child: columnCard(
                                    json
                                        .decode(snapshot.data.toString())[
                                            'data'][0]['title']
                                        .toString()
                                        .substring(0, 5),
                                    json.decode(
                                            snapshot.data.toString())['data'][0]
                                        ['postBy'],
                                    json.decode(
                                            snapshot.data.toString())['data'][0]
                                        ['image'])),
                            const SizedBox(width: 10.0),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SinglePoet(
                                            shares: 87,
                                            image: json.decode(snapshot.data
                                                    .toString())['data'][1]
                                                ['image'],
                                            title: json.decode(snapshot.data
                                                    .toString())['data'][1]
                                                ['title'],
                                            author: json.decode(snapshot.data
                                                    .toString())['data'][1]
                                                ['postBy'],
                                            comment: 90,
                                            content: json.decode(snapshot.data
                                                    .toString())['data'][1]
                                                ['contDesc'],
                                            datePosted: json.decode(snapshot
                                                .data
                                                .toString())['data'][1]['date'],
                                            likes: 78,
                                            poetId: json.decode(snapshot.data
                                                .toString())['data'][1]['id'],
                                          ))),
                              child: columnCard(
                                  json
                                      .decode(snapshot.data.toString())['data']
                                          [1]['title']
                                      .toString()
                                      .substring(0, 5),
                                  json.decode(snapshot.data.toString())['data']
                                      [1]['postBy'],
                                  json.decode(snapshot.data.toString())['data']
                                      [1]['image']),
                            ),
                            const SizedBox(width: 10.0),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SinglePoet(
                                            shares: 87,
                                            image: json.decode(snapshot.data
                                                    .toString())['data'][2]
                                                ['image'],
                                            title: json.decode(snapshot.data
                                                    .toString())['data'][2]
                                                ['title'],
                                            author: json.decode(snapshot.data
                                                    .toString())['data'][2]
                                                ['postBy'],
                                            comment: 90,
                                            content: json.decode(snapshot.data
                                                    .toString())['data'][2]
                                                ['contDesc'],
                                            datePosted: json.decode(snapshot
                                                .data
                                                .toString())['data'][2]['date'],
                                            likes: 78,
                                            poetId: json.decode(snapshot.data
                                                .toString())['data'][2]['id'],
                                          ))),
                              child: columnCard(
                                  json
                                      .decode(snapshot.data.toString())['data']
                                          [2]['title']
                                      .toString()
                                      .substring(0, 5),
                                  json.decode(snapshot.data.toString())['data']
                                      [2]['postBy'],
                                  json.decode(snapshot.data.toString())['data']
                                      [2]['image']),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Featured Poems",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    Builder(builder: (BuildContext context) {
                      // List<Map<String, dynamic>> items =
                      //     json.decode(snapshot.data.toString());

                      if (snapshot.hasData) {
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: json
                                .decode(snapshot.data.toString())['data']
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SinglePoet(
                                                shares: 87,
                                                image: json.decode(snapshot.data
                                                        .toString())['data']
                                                    [index]['image'],
                                                title: json.decode(snapshot.data
                                                        .toString())['data']
                                                    [index]['title'],
                                                author: json.decode(snapshot
                                                        .data
                                                        .toString())['data']
                                                    [index]['postBy'],
                                                comment: 90,
                                                content: json.decode(snapshot
                                                        .data
                                                        .toString())['data']
                                                    [index]['contDesc'],
                                                datePosted: json.decode(snapshot
                                                        .data
                                                        .toString())['data']
                                                    [index]['date'],
                                                likes: 78,
                                                poetId: json.decode(snapshot
                                                        .data
                                                        .toString())['data']
                                                    [index]['id'],
                                              ))),
                                  child: Visibility(
                                    visible:
                                        json.decode(snapshot.data.toString())[
                                                'data'][index]['catId'] ==
                                            1,
                                    replacement: const SizedBox.shrink(),
                                    child: poemCard(
                                        json
                                                    .decode(snapshot.data.toString())['data']
                                                        [index]['title']
                                                    .toString()
                                                    .length <=
                                                15
                                            ? json
                                                .decode(snapshot.data.toString())[
                                                    'data'][index]['title']
                                                .toString()
                                            : "${json.decode(snapshot.data.toString())['data'][index]['title'].toString().substring(0, 14)}...",
                                        json.decode(snapshot.data.toString())['data']
                                            [index]['postBy'],
                                        json.decode(snapshot.data.toString())['data']
                                            [index]['date'],
                                        json.decode(snapshot.data.toString())['data']
                                            [index]['image']),
                                  ));
                            });
                      }
                      return const Center(child: Text("Something went wrong"));
                    })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
