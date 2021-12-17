import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PoetryDetailScreen extends StatelessWidget {
  const PoetryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.back)),
          title: const Text(
            "Burnt Coins",
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Burnt Coins",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        )),
                    const Text(
                      "by Enoch Ojototisa",
                      style: TextStyle(color: Colors.grey),
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            './assets/images/bg.jpeg',
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      """Crashed economies,
deaths in the fields of nations,
men and women facing this plague,
so strong and too potent to be treated.
        
Pharmaceuticals are silenced by its rage,
COVID-19, grown too strong for 2020,
should have just been called COVID;
many economies now simply broken.
        
Africa is rich with her herbs,
yet, the cold weathered hands clap still,
denying the organic concoction of Africa,
like previous plagues, drink Africa’s plants.
        
""",
                      softWrap: true,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Comments",
                      style: TextStyle(color: Colors.blue),
                    ),
                    const Text(
                      "Nice and cool poetry...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text("@sammy"),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text("Pretty beautiful",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text("@oladele"),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Write comment here..."),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.chevron_forward))
                      ],
                    )))
          ],
        ));
  }
}
