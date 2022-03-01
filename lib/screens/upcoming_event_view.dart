import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingEventView extends StatefulWidget {
  String? image;
  String? title;
  String? date;
  String? time;
  String? description;
  String? location;
  String? subtitle;

  UpcomingEventView(
      {this.image,
      this.title,
      this.date,
      this.time,
      this.description,
      this.location,
      this.subtitle});

  @override
  _UpcomingEventViewState createState() => _UpcomingEventViewState();
}

class _UpcomingEventViewState extends State<UpcomingEventView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      widget.image.toString(),
                      height: 315,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.black26),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Starts in",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        eventTimeCard(widget.date.toString())
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18.0),
                            topLeft: Radius.circular(18.0))),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.subtitle.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(
                              widget.title.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "${widget.date} | ${widget.time}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.description.toString()),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Attendance",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Set Reminder",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: const [Text("Yes"), Text("21")],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 40,
                                  width: 2.0,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: const [Text("No"), Text("43")],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 40,
                                  width: 2.0,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: const [Text("Maybe"), Text("23")],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                attendanceCard("Yes", Colors.black),
                                const SizedBox(
                                  width: 5,
                                ),
                                attendanceCard("No", Colors.blue),
                                const SizedBox(
                                  width: 5,
                                ),
                                attendanceCard("Maybe", Colors.grey)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(widget.location.toString())
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
