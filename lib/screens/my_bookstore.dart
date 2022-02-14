import 'package:akewiartshouse/screens/my_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
          title: const Text(
            "My bookstore",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 40, left: 40),
          child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyBook(
                                book_id: 20,
                                title: "Commoner's cry",
                                image:
                                    'https://i.ibb.co/R6pg49X/koins-full-logo.png',
                                shares: '320',
                                likes: '32',
                                author: 'Samuel',
                                version: 'Audio',
                                comments: '231',
                                amount: '2,394',
                                description:
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                              ))),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      './assets/images/book_cover1.png'),
                                  fit: BoxFit.cover)),
                        )),
                        const Text(
                          "Commoner's cry",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                            children: List.generate(
                          5,
                          (index) => const Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.black54,
                            size: 13,
                          ),
                        )),
                        const Text(
                          "N 2,309",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Published 1 week ago",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
