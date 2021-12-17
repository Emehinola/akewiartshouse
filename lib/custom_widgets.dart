import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/screens/screens.dart';

Container poetCard(String title, String imagePath) {
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
              backgroundImage: AssetImage(
                imagePath,
              ),
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
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  Text("by Enoch Ojotisa"),
                  Text("Click to read poetry",
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

Container productCard(String image, String productName) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5, right: 0),
    width: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  image,
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 3,
              child: Container(
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[100]),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.heart,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
        Text(
          productName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "\$50.9",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[100]),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
              blurRadius: 0.8,
              spreadRadius: 1.0,
              offset: Offset(1, 1),
              color: Colors.black12)
        ]),
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
Column itemCard(String text, String imagePath, Color color) {
  return Column(
    children: [
      Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          margin: const EdgeInsets.only(right: 5.0, top: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imagePath,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
          )),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ],
  );
}

SizedBox politicsCard(BuildContext context) {
  return SizedBox(
    height: 100,
    child: GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SinglePolitics())),
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
    BuildContext context, String imagePath, String description, String author) {
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
          children: [
            Text(description, style: const TextStyle(fontSize: 18)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              priceTag("24.5"),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PaymentPage())),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.lightBlue,
                      ),
                      child: const Text("Buy Now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white))))
            ]),
            Text("designed by $author",
                style: const TextStyle(fontSize: 20, color: Colors.grey))
          ],
        ),
      )
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

Container priceTag(String amount) {
  return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey,
      ),
      child: Text("\$$amount",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)));
}
