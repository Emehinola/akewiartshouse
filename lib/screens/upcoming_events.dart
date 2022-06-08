import 'dart:convert';

import 'package:akewiartshouse/backend/getter.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class UpcomingEvent extends StatefulWidget {
  @override
  State<UpcomingEvent> createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  fetchEvent() async {
    dynamic response = await http.get(
      Uri.parse(
          '${EndPoint.baseUrl}/api/Events/getListOfEventsByStatus/upcoming'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Database.box.get('authorization')}'
      },
    );
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: fetchEvent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List data = jsonDecode(snapshot.data.toString())['data'];
            if (data.isEmpty) {
              return const Center(child: Text("No Upcoming Events"));
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpcomingEventView(
                                title: data[index]['title'],
                                eventId: data[index]['id'],
                                image: data[index]['banner'],
                                date: data[index]['eventDate'],
                                description: data[index]['description'],
                                location: data[index]['location'],
                                subtitle: data[index]['subTitle'],
                                time: data[index]['time'],
                              ))),
                  child: upcomingEventCard(
                    title: data[index]['title'] ?? "",
                    subtitle: data[index]['subTitle'] ?? "",
                    imagePath: data[index]['banner'],
                    eventDate: data[index]['eventDate'] ?? '',
                  ),
                );
              },
              itemCount: data.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15);
              },
            );
          }
        },
      ),
    );
  }
}
