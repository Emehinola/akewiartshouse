import 'package:akewiartshouse/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controllers
    TextEditingController fullName = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController phone = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 700,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('./assets/images/prof_bg.png'),
                              fit: BoxFit.cover))),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.left_chevron,
                          color: Colors.black,
                        )),
                  ),
                  Positioned(
                    top: 100,
                    child: Container(
                        height: 700,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0))),
                        child: const SizedBox.shrink()),
                  ),
                  const Positioned(
                      left: 125,
                      top: 40,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('./assets/images/profile_image.png'),
                        ),
                      )),
                  Positioned(
                    right: 140,
                    top: 120,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        CupertinoIcons.photo_camera,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 120,
                    child: GestureDetector(
                      onTap: () {
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Edit profile",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                              IconButton(
                                                  icon: const Icon(
                                                    CupertinoIcons.xmark,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText: "full name",
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
                                                      hintText: "username",
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
                                                      hintText: "pet name",
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
                                                      hintText: "Phone number",
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
                                                    const EdgeInsets.all(8.0),
                                                height: 70,
                                                child: InkWell(
                                                  onTap: () {
                                                    // TODO
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 20.0),
                                                    alignment: Alignment.center,
                                                    height: 45,
                                                    child: const Text(
                                                      "Update",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
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
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(17.0)),
                          child: const Text(
                            "Edit profile",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      left: 0,
                      top: 150,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: const [
                            Text(
                              "Emeh Samurl",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Samurl",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Text("+234892094894",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Text("developer@mail.com",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Divider(
                              indent: 10.0,
                              endIndent: 10.0,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )),
                  const Positioned(
                      top: 250,
                      right: 20,
                      child: Icon(
                        FontAwesomeIcons.edit,
                        size: 15,
                      )),
                  Positioned(
                      top: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, right: 20, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About me",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Text("Bio",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. \nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, \nwhen an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book\nContrary to popular belief, Lorem Ipsum is not simply random text. \n\nIt has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. \n\nRichard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. \n\nLorem Ipsum comes from sections 1.10.32 and 1.10.33 of",
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                            const Divider(
                              indent: 10.0,
                              endIndent: 10.0,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Text("Facebook",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Instagram",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Twitter",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Website",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            const Divider(
                              color: Colors.grey,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Password",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 220,
                                ),
                                Text("change")
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("***********",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
