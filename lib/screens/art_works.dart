import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:http/http.dart' as http;

class ArtWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // getting all photographs
    Future getPhotographs() async {
      var response = await http.get(
          Uri.parse(
              'http://placid-001-site50.itempurl.com/api/Photography/getAllPhotography'),
          headers: {
            'Authorization': 'Bearer ${Database.box.get('authorization')}',
            'Content-Type': 'application/json'
          });

      return response.body;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: const Text(
          "Photography",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: FutureBuilder(
            future: getPhotographs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureDisplay(
                                    title: json.decode(
                                            snapshot.data.toString())['data']
                                        [index]['title'],
                                    images: json.decode(
                                            snapshot.data.toString())['data']
                                        [index]['images'],
                                  ))),
                      child: artWorkCard(
                          context,
                          json.decode(snapshot.data.toString())['data'][index]
                              ['images'],
                          json.decode(snapshot.data.toString())['data'][index]
                              ['description'],
                          'Sam',
                          json.decode(snapshot.data.toString())['data'][index]
                              ['title']),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount:
                      json.decode(snapshot.data.toString())['data'].length);
            }),
      ),
    );
  }
}
