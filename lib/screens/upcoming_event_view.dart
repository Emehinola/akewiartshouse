import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingEventView extends StatefulWidget {
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
                    child: Image.asset(
                      './assets/images/bg.jpeg',
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
                            onPressed: () {},
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
                        eventTimeCard("00:21:32:09")
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18.0),
                            topLeft: Radius.circular(18.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "GBVN Hangout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const Text(
                            "Home Drive Hangout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text(
                            "Feb 5, 2022 | 5:13pm",
                            style: TextStyle(
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
                          const Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \n\nwhen an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
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
                          const Text(
                              "GBVN studio, Ifeoluwa\nAirport Quarter, Alakia Ibadan")
                        ],
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
