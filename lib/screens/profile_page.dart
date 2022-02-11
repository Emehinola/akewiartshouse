import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text("Sam"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.chevron_back)),
        actions: [
          Row(
            children: [
              const Text(
                "Logout",
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
                                const ProfilePage())),
                    icon: const Icon(CupertinoIcons.airplane)),
              )
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.asset(
                  './assets/images/bg.jpeg',
                  height: 100,
                  width: 100,
                ),
              ),
              const Text("Johnson Sam",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.lightBlue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    Positioned(
                        bottom: 15.0,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          height: 160.0,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Colors.lightBlue, Colors.purple],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(CupertinoIcons.phone_fill,
                                      color: Colors.white),
                                  SizedBox(width: 5.0),
                                  Text("+234-656-4367-843",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(CupertinoIcons.mail_solid,
                                      color: Colors.white),
                                  SizedBox(width: 5.0),
                                  Text("admin@akewiarts.com",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(CupertinoIcons.house,
                                      color: Colors.white),
                                  SizedBox(width: 5.0),
                                  Text("21, Gladys close",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text("Poetry",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: poetCard("Holes", "", './assets/images/events.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: poetCard("Mood Swings", "", './assets/images/music.jpg'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
