import 'package:akewiartshouse/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateLiterature extends StatefulWidget {
  @override
  _CreateLiteratureState createState() => _CreateLiteratureState();
}

class _CreateLiteratureState extends State<CreateLiterature> {
  // controllers
  TextEditingController categoryCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Create new literature post",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        content: SizedBox(
                          height: 250,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Select an option",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    IconButton(
                                        icon: const Icon(
                                          CupertinoIcons.xmark,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => Navigator.pop(context))
                                  ],
                                ),
                              ),
                              Container(
                                  height: 200,
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              categoryCtrl.text = 'Poetry';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 120,
                                            width: 70,
                                            child: literatureOptionsCard(
                                                "Poetry",
                                                "./assets/images/poem.png"),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              categoryCtrl.text = 'Drama';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 120,
                                            width: 70,
                                            child: literatureOptionsCard(
                                                "Drama",
                                                "./assets/images/drama.png"),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              categoryCtrl.text = 'Essay';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 120,
                                            width: 70,
                                            child: literatureOptionsCard(
                                                "Essay",
                                                "./assets/images/essay.png"),
                                          ),
                                        ),
                                      ])),
                            ],
                          ),
                        ),
                      )),
              child: SizedBox(
                height: 45,
                child: TextField(
                  enabled: false,
                  controller: categoryCtrl,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(CupertinoIcons.chevron_down),
                      hintText: "Select category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              child: TextField(
                minLines: 5,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Description/write up",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Featured images",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(
              height: 5,
            ),
            imageSelectionCard(context),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black),
              child: const Text(
                "Submit",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
