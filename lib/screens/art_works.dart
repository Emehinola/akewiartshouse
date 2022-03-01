import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:http/http.dart' as http;

import 'create_photograph.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreatePhotograph())),
        backgroundColor: Colors.black,
        child: const Icon(
          CupertinoIcons.add,
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
              if (snapshot.hasError) {
                return const Center(
                  child:
                      Text("Something went wrong, please check your internet"),
                );
              }
              try {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PictureDisplay(
                                      photoId: json.decode(
                                              snapshot.data.toString())['data']
                                          [index]['id'],
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
                                ['image'],
                            json.decode(snapshot.data.toString())['data'][index]
                                ['description'],
                            'Sam',
                            json.decode(snapshot.data.toString())['data'][index]
                                ['title'],
                            json.decode(snapshot.data.toString())['data'][index]
                                ['date']),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount:
                        json.decode(snapshot.data.toString())['data'].length);
              } catch (error) {
                return const Center(
                  child:
                      Text("Something went wrong, please check your internet"),
                );
              }
            }),
      ),
    );
  }
}
