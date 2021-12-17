import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';

class SinglePolitics extends StatelessWidget {
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
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Image.asset(
            './assets/images/painting.jpg',
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Title goes here for the first post on politics, very lite",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("posted by Sammy. E",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            CupertinoIcons.time,
                            color: Colors.grey,
                          ),
                          Text(
                            "21, April, 2021",
                            style: TextStyle(color: Colors.grey),
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
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "28",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(width: 15.0),
                      Row(
                        children: const [
                          Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "41",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 

It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 

It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                  """,
                    style: TextStyle(fontSize: 17),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: "Write comment here...",
                        suffix: Icon(
                          CupertinoIcons.arrowtriangle_right,
                          color: Colors.green,
                        )),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
