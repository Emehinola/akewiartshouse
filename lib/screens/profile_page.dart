import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/backend/getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as launcher;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  bool loading = false;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // getting user's details
    Future getUserProfile() async {
      var response = await http.get(
          Uri.parse(
            'http://placid-001-site50.itempurl.com/api/User/getUserByEmail/${Database.box.get('email')}',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Database.box.get('authorization')}'
          });

      return response.body;
    }

    void launchURL(String url) async {
      if (!await launcher.launch(url)) throw 'Could not launch $url';
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 720,
                child: FutureBuilder(
                  future: getUserProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      Map<String, dynamic> _data =
                          jsonDecode(snapshot.data.toString())['data'];
                      // controllers
                      TextEditingController firstName =
                          TextEditingController(text: _data['firstname']);
                      TextEditingController lastName =
                          TextEditingController(text: _data['lastname']);
                      TextEditingController username =
                          TextEditingController(text: _data['username']);
                      TextEditingController phonenumber =
                          TextEditingController(text: _data['phonenumber']);
                      TextEditingController bio =
                          TextEditingController(text: _data['bio']);
                      TextEditingController facebook =
                          TextEditingController(text: _data['facebook']);
                      TextEditingController instagram =
                          TextEditingController(text: _data['instagram']);
                      TextEditingController twitter =
                          TextEditingController(text: _data['twitter']);
                      TextEditingController website =
                          TextEditingController(text: _data['website']);
                      TextEditingController cpwd = TextEditingController();
                      TextEditingController npwd = TextEditingController();
                      TextEditingController confirmpwd =
                          TextEditingController();
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('./assets/images/prof_bg.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                CupertinoIcons.left_chevron,
                                color: Colors.black,
                              ),
                            ),
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
                                  topLeft: Radius.circular(12.0),
                                ),
                              ),
                              child: const SizedBox.shrink(),
                            ),
                          ),
                          const Positioned(
                              left: 0,
                              right: 0,
                              top: 40,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      './assets/images/profile_image.png'),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      Navigator.pop(context),
                                                )
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
                                                    controller: firstName,
                                                    decoration: InputDecoration(
                                                        hintText: "first name",
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
                                                    controller: lastName,
                                                    decoration: InputDecoration(
                                                        hintText: "last name",
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
                                                    controller: username,
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
                                                    controller: phonenumber,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Phone number",
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
                                                    onTap: () async {
                                                      String _firstName =
                                                              firstName.text,
                                                          _lastName =
                                                              lastName.text,
                                                          _userName =
                                                              username.text,
                                                          _phoneNumber =
                                                              phonenumber.text;
                                                      if (_firstName == '' ||
                                                          _lastName == '' ||
                                                          _userName == '' ||
                                                          _phoneNumber == '') {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'One or more of the fields are empty!',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                      } else {
                                                        setState(() {
                                                          widget.loading = true;
                                                        });
                                                        var _response =
                                                            await http.post(
                                                          Uri.parse(
                                                              'http://placid-001-site50.itempurl.com/api/User/update-user'),
                                                          headers: <String,
                                                              String>{
                                                            'Content-Type':
                                                                'application/json',
                                                            'Authorization':
                                                                'Bearer ${Database.box.get('authorization')}'
                                                          },
                                                          body: jsonEncode({
                                                            'email': Database
                                                                .box
                                                                .get('email'),
                                                            'password': Database
                                                                .box
                                                                .get(
                                                                    'password'),
                                                            'firstname':
                                                                _firstName,
                                                            'lastname':
                                                                _lastName,
                                                            'username':
                                                                _userName,
                                                            'phonenumber':
                                                                _phoneNumber,
                                                          }),
                                                        );
                                                        dynamic _data =
                                                            jsonDecode(
                                                                _response.body);
                                                        if (_data['status'] ==
                                                            'success') {
                                                          setState(() {
                                                            widget.loading =
                                                                true;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Profile edited successfully!')));
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      ProfilePage()));
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 20.0),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 45,
                                                      child: Text(
                                                        widget.loading
                                                            ? 'Updating...'
                                                            : 'Update',
                                                        style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
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
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black87, width: 2.0),
                                    borderRadius: BorderRadius.circular(17.0)),
                                child: const Text(
                                  "Edit profile",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              left: 0,
                              top: 150,
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      '${_data['firstname'] ?? 'John Doe'} ${_data['lastname'] ?? ''}',
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("@${_data['username'] ?? '@johndoe'}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${_data['phonenumber'] ?? '+1 (217) 320 5064'}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Text("${_data['email'] ?? 'john@doe.com'}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    const Divider(
                                        indent: 10.0,
                                        endIndent: 10.0,
                                        color: Colors.grey)
                                  ],
                                ),
                              )),
                          Positioned(
                            top: 260,
                            right: 20,
                            child: GestureDetector(
                              child: const Icon(
                                FontAwesomeIcons.edit,
                                size: 15,
                              ),
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    content: SingleChildScrollView(
                                      child: SizedBox(
                                        height: 510,
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
                                                    child: Text("Edit profile",
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
                                                    height: 100,
                                                    child: TextFormField(
                                                      controller: bio,
                                                      minLines: 4,
                                                      maxLines: 5,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration: InputDecoration(
                                                          hintText: "Bio",
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
                                                      controller: facebook,
                                                      decoration: InputDecoration(
                                                          hintText: "facebook",
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
                                                      controller: instagram,
                                                      decoration: InputDecoration(
                                                          hintText: "instagram",
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
                                                      controller: twitter,
                                                      decoration: InputDecoration(
                                                          hintText: "twitter",
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
                                                      controller: website,
                                                      decoration: InputDecoration(
                                                          hintText: "website",
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
                                                      onTap: () async {
                                                        if (bio.text == '' ||
                                                            facebook.text ==
                                                                '' ||
                                                            instagram.text ==
                                                                '' ||
                                                            twitter.text ==
                                                                '' ||
                                                            website.text ==
                                                                '') {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                'One or more of the fields are empty!',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ),
                                                          );
                                                        } else {
                                                          setState(() {
                                                            widget.loading =
                                                                true;
                                                          });
                                                          var _response =
                                                              await http.post(
                                                            Uri.parse(
                                                                'http://placid-001-site50.itempurl.com/api/User/update-user'),
                                                            headers: <String,
                                                                String>{
                                                              'Content-Type':
                                                                  'application/json',
                                                              'Authorization':
                                                                  'Bearer ${Database.box.get('authorization')}'
                                                            },
                                                            body: jsonEncode({
                                                              'email': Database
                                                                  .box
                                                                  .get('email'),
                                                              'password': Database
                                                                  .box
                                                                  .get(
                                                                      'password'),
                                                              'bio': bio.text,
                                                              'facebook':
                                                                  facebook.text,
                                                              'instagram':
                                                                  instagram
                                                                      .text,
                                                              'twitter':
                                                                  twitter.text,
                                                              'website':
                                                                  website.text,
                                                            }),
                                                          );
                                                          dynamic _data =
                                                              jsonDecode(
                                                                  _response
                                                                      .body);
                                                          if (_data['status'] ==
                                                              'success') {
                                                            setState(() {
                                                              widget.loading =
                                                                  true;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Profile edited successfully!')));
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        ProfilePage()));
                                                          }
                                                        }
                                                      },
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
                                                        child: Text(
                                                          widget.loading
                                                              ? 'Updating...'
                                                              : 'Update',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                              top: 260,
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
                                    Text(
                                        '${_data['bio'] ?? 'Click the Edit Button to add a Bio to your profile.'}',
                                        style: const TextStyle(
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
                                      children: [
                                        TextButton(
                                          onPressed: _data['facebook'] == null
                                              ? null
                                              : () {
                                                  launchURL(_data['facebook']);
                                                },
                                          child: const Text("Facebook",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                          onPressed: _data['instagram'] == null
                                              ? null
                                              : () {
                                                  launchURL(_data['instagram']);
                                                },
                                          child: const Text("Instagram",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                          onPressed: _data['twitter'] == null
                                              ? null
                                              : () {
                                                  launchURL(_data['twitter']);
                                                },
                                          child: const Text("Twitter",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                      onPressed: _data['website'] == null
                                          ? null
                                          : () {
                                              launchURL(_data['website']);
                                            },
                                      child: const Text("Website",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Password",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          width: 220,
                                        ),
                                        GestureDetector(
                                            child: const Text("change"),
                                            onTap: () => showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      content:
                                                          SingleChildScrollView(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        child: SizedBox(
                                                          height: 340,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        30.0),
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                12.0),
                                                                        topRight:
                                                                            Radius.circular(12.0))),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          "Change password",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white)),
                                                                    ),
                                                                    IconButton(
                                                                        icon:
                                                                            const Icon(
                                                                          CupertinoIcons
                                                                              .xmark,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context))
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        15.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            cpwd,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                "current password",
                                                                            border:
                                                                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            npwd,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                "new password",
                                                                            border:
                                                                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            confirmpwd,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                "confirm password",
                                                                            border:
                                                                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    Container(
                                                                      width:
                                                                          300,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      height:
                                                                          70,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          if (cpwd.text == '' ||
                                                                              npwd.text == '' ||
                                                                              confirmpwd.text == '') {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              const SnackBar(
                                                                                content: Text(
                                                                                  'One or more of the fields are empty!',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                                backgroundColor: Colors.red,
                                                                              ),
                                                                            );
                                                                          } else if (cpwd.text !=
                                                                              Database.box.get('password')) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              const SnackBar(
                                                                                content: Text(
                                                                                  'Invalid Password!',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                                backgroundColor: Colors.red,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            setState(() {
                                                                              widget.loading = true;
                                                                            });
                                                                            var _response =
                                                                                await http.post(
                                                                              Uri.parse('http://placid-001-site50.itempurl.com/api/User/change-password'),
                                                                              headers: <String, String>{
                                                                                'Content-Type': 'application/json',
                                                                                'Authorization': 'Bearer ${Database.box.get('authorization')}'
                                                                              },
                                                                              body: jsonEncode({
                                                                                'email': Database.box.get('email'),
                                                                                'newPassword': npwd.text,
                                                                              }),
                                                                            );
                                                                            dynamic
                                                                                _data =
                                                                                jsonDecode(_response.body);
                                                                            if (_data['status'] ==
                                                                                'success') {
                                                                              Database.box.put('password', npwd.text);
                                                                              setState(() {
                                                                                widget.loading = true;
                                                                              });
                                                                              Navigator.pop(context);
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed successfully!')));
                                                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                                                                            }
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 5.0,
                                                                              horizontal: 20.0),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              const Text(
                                                                            "Change",
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )))
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
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
