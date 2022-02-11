import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class EndPoint {
  var login = 'http://placid-001-site50.itempurl.com/api/User/login';
}

class Database {
  static final box = Hive.box('akewiartshouse');
}

// poetry
class Poetry {
  final String? title;
  final String? imageScr;
  final String? author;
  final String? content;
  final String? timePublished;

  Poetry(
      {this.author,
      this.title,
      this.content,
      this.imageScr,
      this.timePublished});

  factory Poetry.fromJson(Map<String, dynamic> json) {
    return Poetry(
        author: json['author'],
        content: json['content'],
        imageScr: json['imageSrc'],
        timePublished: json['timePublished'],
        title: json['title']);
  }
}
