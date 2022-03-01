import 'dart:convert';
import 'dart:io';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PastEvent extends StatelessWidget {
  // open past event on youtube
  void openYoutube(String youtubeId) async {
    var link = "https://youtube.com/watch/?v=$youtubeId";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(link)) {
        await launch(link, forceSafariVC: false);
      } else {
        //
      }
    }

    // launching based on platform
    else if (Platform.isIOS) {
      //
    } else if (Platform.isAndroid) {
      if (await canLaunch(link)) {
        launch(link); // launches whatsapp
      } else {
        //
      }
    }
  }

  // get past events
  Future getEvents() async {
    var request = await http.get(
        Uri.parse(
            'http://placid-001-site50.itempurl.com/api/Events/getListOfEvents'),
        headers: {
          'Authorization': 'Bearer ${Database.box.get('authorization')}',
          'Content-Type': 'application/json'
        });

    return request.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var result = json.decode(snapshot.data.toString())['data'];
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: searchContainer("Search by title, organizer"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: GridView.builder(
                          itemCount: result.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () =>
                                    openYoutube(result[index]['youtubeId']),
                                child: pastEventCard(
                                    result[index]['title'],
                                    '1hr 3mins',
                                    'Feb 3, 2022',
                                    '4:32',
                                    result[index]['banner']));
                          }),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
