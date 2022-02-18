import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
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
          "Help/Support",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
                "For suggestions, compaints, and enquiries kindly reach out to us through the following channels"),
            SizedBox(height: 20),
            Text("Website",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            SizedBox(height: 10),
            Text("www.akewiartshouse.com",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            Text("Email",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            SizedBox(height: 10),
            Text("info@akewiartshouse.com",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("FAQ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            SizedBox(height: 10),
            Text("www.akewiartshouse.com/faq",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Chat with us on whatsapp",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            SizedBox(height: 10),
            Text("+2348012345678, +2348087654321",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Contact address",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            SizedBox(height: 10),
            Text(
                "No 1, Mission office,\nIfeoluwa street, Beside new Airport,\nAlakia, Ibadan,\nOyo state, Nigeria.",
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      )),
    );
  }
}
