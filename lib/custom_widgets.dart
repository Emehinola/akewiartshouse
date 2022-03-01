import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:date_count_down/date_count_down.dart';

Container poetCard(String title, String author, String imagePath) {
  return Container(
    height: 105,
    padding: const EdgeInsets.all(15.0),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imagePath),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  Text("by $author"),
                  const Text("Click to read poetry",
                      style: TextStyle(color: Colors.red))
                ],
              ),
            ),
          ]),
        ),
        IconButton(
            onPressed: () {}, icon: const Icon(CupertinoIcons.chat_bubble)),
        const Text("981"),
        IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.heart_fill, color: Colors.red)),
        const Text("2k")
      ],
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
              blurRadius: 0.8,
              spreadRadius: 1.0,
              offset: Offset(1, 1),
              color: Colors.black12)
        ]),
  );
}

Stack profileCard() {
  return Stack();
}

// for books
Container booksCard(
    String title, String amount, bool inWishList, String imagePath) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Colors.lightBlue, Colors.orangeAccent, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        color: Colors.red,
        borderRadius: BorderRadius.circular(4.0)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
              Text(amount,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.0)),
                    height: 35.0,
                    child: const Text("Add to Cart",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(CupertinoIcons.heart, color: Colors.white))
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

// horizontal music list card
Container musicListCard(String image, String name, String author) {
  return Container(
    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5, right: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Image.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        Text(
          author,
          style: const TextStyle(
              fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
    ),
  );
}

Container productCard(String image, String productName, String author) {
  return Container(
    height: 100,
    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5, right: 0),
    width: 90,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill)),
          ),
        ),
        Text(
          author,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(
          productName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        )
      ],
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
    ),
  );
}

Container roundedContainer(Widget child) {
  return Container(
    margin: const EdgeInsets.all(5.0),
    height: 40,
    width: 40,
    decoration: BoxDecoration(
        color: Colors.grey, borderRadius: BorderRadius.circular(30.0)),
    child: child,
  );
}

// cards
Container itemCard(String text, String imagePath, Color color) {
  return Container(
    height: 110,
    width: 110,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 5),
            spreadRadius: 0,
            blurRadius: 3.0),
      ],
      borderRadius: BorderRadius.circular(7.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 7,
        ),
        Image.asset(imagePath, height: 70, width: 70),
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 3,
        ),
      ],
    ),
  );
}

SizedBox politicsCard(BuildContext context) {
  return SizedBox(
    height: 100,
    child: GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SinglePost())),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 0.8,
                  spreadRadius: 2.0,
                  color: Colors.black12)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  './assets/images/painting.jpg',
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "The post title goes here for the first post",
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "Post content follows here... rest truncated...",
                    style: TextStyle(fontSize: 17, color: Colors.grey),
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
                          Text(
                            "28",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

SizedBox musicRow(
    String number, String imagePath, String title, String subtitle) {
  return SizedBox(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Text(number,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(width: 3),
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(imagePath, height: 80, width: 80)),
          const SizedBox(width: 5.0),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18)),
            Text(subtitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                    fontSize: 16))
          ]),
        ],
      ),
      const Icon(CupertinoIcons.bars, color: Colors.white)
    ]),
  );
}

Container artWorkCard(
    BuildContext context,
    List<dynamic> images,
    String defaultImage,
    String description,
    String author,
    String title,
    String date) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    height: 290,
    width: double.infinity,
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(6, 1),
              blurRadius: 8,
              spreadRadius: 1.0,
              color: Colors.black26)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Posted $date"),
          )),
      images.length > 3
          ? Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(images[0]['link']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(images[1]['link']),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(images[2]['link']),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              color: Colors.black26,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${images.length - 3}+",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )
          : const SizedBox.shrink(),
      images.length == 3
          ? Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(images[0]['link']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(images[1]['link']),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(images[2]['link']),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )
          : const SizedBox.shrink(),
      images.length == 2
          ? Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(images[0]['link']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(images[1]['link']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
      images.length == 1
          ? Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(defaultImage),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(images[0]['link']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
      images.isEmpty
          ? Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(defaultImage), fit: BoxFit.cover)),
              ),
            )
          : const SizedBox.shrink(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                "${title.toString().length <= 10 ? title.toString() : title.toString().substring(0, 10)}...",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(CupertinoIcons.heart_fill, color: Colors.red),
                  Text("198", style: TextStyle(color: Colors.black54)),
                ],
              ),
              const SizedBox(
                width: 7,
              ),
              Row(children: const [
                Icon(
                  FontAwesomeIcons.shareAlt,
                  color: Colors.grey,
                  size: 15,
                ),
                Text("198", style: TextStyle(color: Colors.black54)),
              ]),
              const SizedBox(
                width: 7,
              ),
              Row(children: const [
                Icon(CupertinoIcons.chat_bubble, color: Colors.grey),
                Text("46", style: TextStyle(color: Colors.black54)),
              ])
            ],
          )
        ],
      ),
      Text(description)
    ]),
  );
}

Container editorialCard(BuildContext context, String imagePath, String title,
    String content, String category, String author) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 0.8,
              spreadRadius: 1.0,
              color: Colors.grey)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset(imagePath),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(content,
                style: const TextStyle(
                  fontSize: 18,
                )),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Icon(CupertinoIcons.heart_fill, color: Colors.red),
              Text(category)
            ]),
            const SizedBox(height: 5),
            Text("written by $author | 23rd D ec, 2021",
                style: const TextStyle(fontSize: 20, color: Colors.grey))
          ],
        ),
      )
    ]),
  );
}

Container priceTag() {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
      ),
      child: const Text("Buy Now",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)));
}

Container downloadTag() {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Download",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white)),
          SizedBox(
            width: 7,
          ),
          Text("|",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white)),
          SizedBox(
            width: 3,
          ),
          Icon(
            CupertinoIcons.chevron_down,
            color: Colors.white,
          )
        ],
      ));
}

Column literatureOptionsCard(String text, String imagePath) {
  return Column(
    children: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15.0),
        height: 70,
        width: 70,
        color: Colors.grey[300],
        child: Image.asset(imagePath),
      ),
      const SizedBox(height: 5),
      Text(text, style: const TextStyle(fontWeight: FontWeight.bold))
    ],
  );
}

// music tile
Container bookSaleCard(
    String image, String title, String author, String amount, int rating) {
  return Container(
    height: 140,
    padding: const EdgeInsets.all(15.0),
    width: double.infinity,
    margin: const EdgeInsets.all(5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                )),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(author),
                      Row(
                          children: List.generate(
                        rating,
                        (index) => const Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.black54,
                          size: 17,
                        ),
                      )),
                      Text(
                        "NGN $amount",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        height: 30,
                        alignment: Alignment.centerRight,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Add to basket",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              CupertinoIcons.shopping_cart,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 2.0,
              offset: Offset(1, 1),
              color: Colors.black12)
        ]),
  );
}

Container musicTile(
    String imagePath, String title, String artist, String duration) {
  return Container(
      height: 70,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(1, 1),
                color: Colors.black12)
          ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Image.network(imagePath, height: 55),
          const SizedBox(width: 5),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12)),
                Text(artist,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 12)),
                Text(duration,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12)),
              ])
        ]),
        Row(
          children: const [
            Icon(CupertinoIcons.play_arrow_solid, color: Colors.black),
            SizedBox(width: 15),
            Icon(CupertinoIcons.heart, color: Colors.black),
            SizedBox(width: 15),
            Icon(CupertinoIcons.ellipsis_vertical, color: Colors.black),
          ],
        )
      ]));
}

Container poemCard(String title, String author, String date, String imagePath) {
  return Container(
    height: 150,
    padding: const EdgeInsets.all(15.0),
    margin: const EdgeInsets.all(5.0),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(children: [
            Container(
              width: 120,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: NetworkImage(imagePath), fit: BoxFit.fill)),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "By $author",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text("Posted $date",
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(CupertinoIcons.heart, color: Colors.grey),
                            Text("198",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                        Row(children: const [
                          Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Colors.grey,
                            size: 15,
                          ),
                          Text("198", style: TextStyle(color: Colors.black54)),
                        ]),
                        Row(children: const [
                          Icon(CupertinoIcons.chat_bubble, color: Colors.grey),
                          Text("46", style: TextStyle(color: Colors.black54)),
                        ])
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 2.0,
              offset: Offset(0, 2),
              color: Colors.black12)
        ]),
  );
}

columnCard(String title, String author, String imagePath) {
  return Container(
      height: 130,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(imagePath), fit: BoxFit.cover)),
            ),
          ),
          Text(author, style: const TextStyle(fontSize: 12)),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ));
}

// search container
Container searchContainer(String text) {
  return Container(
    height: 35,
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), color: Colors.grey[300]),
    child: Row(children: [
      const Icon(
        CupertinoIcons.search,
        color: Colors.grey,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        text,
        style: const TextStyle(color: Colors.black54),
      )
    ]),
  );
}

// event type card
Container eventTypeCard(String text, bool live) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    decoration: BoxDecoration(
        color: live ? Colors.black : Colors.grey[350],
        borderRadius: BorderRadius.circular(15.0)),
    child: Text(text,
        style: TextStyle(
            color: live ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold)),
  );
}

// comment tile
Row userCommentTile(String name, String comment, [live = false]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(CupertinoIcons.person_alt_circle_fill, color: Colors.grey),
      const SizedBox(
        width: 5,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: live ? Colors.white : Colors.black),
            ),
            Text(
              comment,
              style: TextStyle(
                  fontSize: 12, color: live ? Colors.white : Colors.black),
            ),
          ],
        ),
      )
    ],
  );
}

// music playing card
Container nowPlayingCard() {
  return Container(
      height: 100,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.black),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Image.asset('./assets/images/music2.png', height: 55),
            const SizedBox(width: 5),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Oremi",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Angelique kodja",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white)),
                  Text("2:34",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ])
          ]),
          Row(
            children: const [
              Icon(CupertinoIcons.pause_solid, color: Colors.white),
              SizedBox(width: 15),
              Icon(CupertinoIcons.heart_fill, color: Colors.red),
              SizedBox(width: 15),
              Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white),
            ],
          )
        ]),
        Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(top: 4.5),
                width: double.infinity,
                height: 5.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0))),
            Container(
              margin: const EdgeInsets.only(top: 4.5),
              color: Colors.red,
              width: 200,
              height: 5.0,
            ),
            Positioned(
                left: 200,
                top: 2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.red),
                  height: 10.0,
                  width: 10.0,
                ))
          ],
        ),
      ]));
}

// upcoming events card
Container upcomingEventCard(
    {required String title,
    required String subtitle,
    required String eventDate,
    required String imagePath}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
    ),
    height: 160,
    width: double.infinity,
    child: Stack(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imagePath),
              ))),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color.fromRGBO(0, 0, 0, 0.70))),
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Text(subtitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12)),
                    ],
                  ),
                ),
                Column(children: [
                  const Text("Starts in",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12)),
                  eventTimeCard(eventDate)
                ])
              ]),
        ),
      )
    ]),
  );
}

Container pastEventCard(
    String title, String duration, String date, String time, String image) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), color: Colors.red),
    height: 200,
    width: 150,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.black26, borderRadius: BorderRadius.circular(12.0)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 7),
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Text(
                    'Past',
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.play_circle,
                color: Colors.white,
                size: 50,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.length >= 15
                          ? "${title.substring(0, 15)}..."
                          : title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Text("Enoch Ojotisa",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text("$date | $time",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

// attendance card
Container attendanceCard(String text, Color bgColor) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15),
    decoration:
        BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5.0)),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

// event time
Container eventTimeCard(String time) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
    child: CountDownText(
      due: DateTime.parse(time),
      finishedText: "Now Live",
      showLabel: true,
      longDateName: true,
      daysTextLong: " DAYS ",
      hoursTextLong: " HOURS ",
      minutesTextLong: " MINUTES ",
      secondsTextLong: " SECONDS ",
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    ),
  );
}

// published posts
Container publishedPostCard(String tag) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), color: Colors.transparent),
    height: 250,
    width: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: const DecorationImage(
                        image: AssetImage('./assets/images/bg.jpeg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: 250,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tag,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        const Text(
          "Oloju dudu",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Text(
          "Published 4 days ago",
          style: TextStyle(),
        )
      ],
    ),
  );
}

// image seslcton card
SizedBox imageSelectionCard(BuildContext context,
    [String text = 'Select image here']) {
  return SizedBox(
    height: 40,
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0))),
            child: Text(text),
          ),
        ),
        Expanded(
          child: Container(
              height: 40,
              width: 30,
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0))),
              child: const Icon(
                CupertinoIcons.cloud_upload,
                color: Colors.white,
              )),
        ),
      ],
    ),
  );
}

Container NotificationTile(String text, String time) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    height: 80,
    width: double.infinity,
    decoration: BoxDecoration(boxShadow: const [
      BoxShadow(
          color: Colors.black26,
          offset: Offset(2, 2),
          blurRadius: 5,
          spreadRadius: 0)
    ], borderRadius: BorderRadius.circular(8.0), color: Colors.grey[200]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline))),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}

/*

showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      content: SizedBox(
                                        height: 400,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  12.0))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text("Payment",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                        CupertinoIcons.xmark,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Card Holder's Name",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Card Number",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Expiration Date",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0))),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                                hintText: "CVV",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0))),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText: "Country",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Container(
                                                    width: 300,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    height: 70,
                                                    child: InkWell(
                                                      onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      contect) =>
                                                                  NavigationScreen())),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5.0,
                                                                horizontal:
                                                                    20.0),
                                                        alignment:
                                                            Alignment.center,
                                                        height: 45,
                                                        child: const Text(
                                                          "Pay Now",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
* */
