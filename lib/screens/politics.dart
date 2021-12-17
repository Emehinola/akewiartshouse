import 'package:akewiartshouse/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class Politics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Politics"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.chevron_back)),
        actions: [
          Row(
            children: [
              const Text(
                "Add",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30.0)),
                child: IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const NavigationScreen())),
                    icon: const Icon(CupertinoIcons.add)),
              )
            ],
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Image.asset(
                './assets/images/events.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black45],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
              ),
              Positioned(
                  bottom: 3,
                  left: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "The title of the post goes here... akhiugurh eryug iuerguiiug",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                CupertinoIcons.time,
                                color: Colors.white,
                              ),
                              Text(
                                "21, April, 2021",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Row(
                            children: const [
                              Icon(
                                CupertinoIcons.chat_bubble,
                                color: Colors.white,
                              ),
                              Text(
                                "28",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return politicsCard(context);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10.0,
                ),
                itemCount: 6,
              ))
        ],
      ),
    );
  }
}
