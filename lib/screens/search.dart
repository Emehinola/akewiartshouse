import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets.dart';
import 'screens.dart';

class SearchScreen extends StatefulWidget {
  String? searchType;
  SearchScreen({Key? key, this.searchType}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchParams = TextEditingController();
  List searchResults = [];
  bool loadingResults = false;

  Future getPostBySearchParam() async {
    setState(() {
      loadingResults = true;
    });
    String searchUrl = widget.searchType == 'politics'
        ? '${EndPoint.baseUrl}/api/Literature/getAllPoliticsBySearch/${_searchParams.text.toString()}'
        : widget.searchType == 'literature'
            ? '${EndPoint.baseUrl}/api/Literature/getAllLiteratureBySearch/${_searchParams.text.toString()}'
            : widget.searchType == 'editorial'
                ? '${EndPoint.baseUrl}/api/Editoral/getAllEditorialBySearch/${_searchParams.text.toString()}'
                : '';
    var response = await http.get(Uri.parse(searchUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Database.box.get('authorization')}'
    });
    setState(() {
      loadingResults = false;
    });
    setState(() {
      searchResults = jsonDecode(response.body)['data'];
    });
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          top: true,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchParams,
                              decoration: const InputDecoration(
                                  hintText:
                                      'Search politics, literature, books'),
                            ),
                          ),
                          IconButton(
                            onPressed: () => getPostBySearchParam(),
                            icon: const Icon(CupertinoIcons.search),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: searchResults.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ListView.separated(
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
                                                  title: searchResults[index]
                                                      ['title'],
                                                  author: searchResults[index]
                                                      ['postedby'],
                                                  likes: searchResults[index]
                                                          ['totalLikes'] ??
                                                      0,
                                                  postId: searchResults[index]
                                                      ['id'],
                                                  category: 'politics',
                                                  shares: 23,
                                                  datePosted:
                                                      searchResults[index]
                                                          ['date'],
                                                  comment: searchResults[index]
                                                          ['totalComments'] ??
                                                      0,
                                                  image: searchResults[index]
                                                      ['image'],
                                                  content: searchResults[index]
                                                      ['description'],
                                                ))),
                                    child: poemCard(
                                        searchResults[index]['totalComments'] ==
                                                null
                                            ? '0'
                                            : searchResults[index]
                                                    ['totalComments']
                                                .toString(),
                                        searchResults[index]['totalLikes'] ==
                                                null
                                            ? '0'
                                            : searchResults[index]['totalLikes']
                                                .toString(),
                                        searchResults[index]['title'],
                                        searchResults[index]['postedby'],
                                        searchResults[index]['date'],
                                        searchResults[index]['image'],
                                        Database.box.get(
                                                'politicsLike${searchResults[index]['id']}',
                                                defaultValue: false)
                                            ? true
                                            : false));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10.0,
                                );
                              },
                              itemCount: searchResults.length),
                        ),
                      ),
                      replacement: SizedBox(
                        height: 500,
                        child: Visibility(
                          visible: !loadingResults,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("No search result"),
                          ),
                          replacement: const SizedBox(
                              height: 50,
                              child: Text("Loading search results...")),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
