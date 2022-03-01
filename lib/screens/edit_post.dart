import 'dart:convert';
import 'dart:io';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/politics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

// for politics and editorial
class EditPost extends StatefulWidget {
  String? title;
  String? author;
  String? category;
  String? content;
  String? image;
  int postId;

  EditPost(
      {this.title,
      this.author,
      this.category,
      this.content,
      this.image,
      required this.postId});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
// controlllers
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController author = TextEditingController();

  // loading controller
  bool loading = false;

  // IMAGE
  File? pickedImage;
  ImagePicker? _imagePicker;

  // get lost data
  getLostData() async {
    final LostDataResponse response = await _imagePicker!.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        pickedImage = File(response.file!.path);
        //
      });
    } else {
      //
    }
  }

  // pick image to upload
  pickImage() async {
    var pickedFile = await _imagePicker!.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(pickedFile!.path);
      // print("picked: $pickedImage");
    });
  }

  // posting article
  Future editPost(String title, String category, String author, imagePath,
      String content, int postId) async {
    try {
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse(category.toLowerCase() == 'politics'
              ? 'http://placid-001-site50.itempurl.com/api/Politics/updatePolitics'
              : 'http://placid-001-site50.itempurl.com/api/Editorial/updateEditorial'));

      if (imagePath != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
      }

      request.fields.addAll({
        'id': postId.toString(),
        'title': title,
        'postedby': author,
        'description': content,
        'userId': Database.box.get('userId').toString()
      });
      request.headers['Authorization'] =
          'Bearer ${Database.box.get('authorization')}';
      // request.headers['Content-Type'] = 'application/json';

      var response = await request.send();
      print('response: ${response.statusCode}');

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post edited successfully")));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Politics()));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unable to submit post. Try again")));
      }
    } catch (error) {
      print(error);
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }

    // print("response: ${response.body}");
  }

  void initState() {
    _imagePicker = ImagePicker();
    categoryCtrl.text = widget.category.toString();
    title.text = widget.title.toString();
    author.text = widget.author.toString();
    content.text = widget.content.toString();

    super.initState();
  }

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
          "Edit post",
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
                controller: title,
                decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                controller: author,
                decoration: InputDecoration(
                    hintText: "Author",
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
                                              categoryCtrl.text = 'Politics';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 120,
                                            width: 70,
                                            child: literatureOptionsCard(
                                                "Politics",
                                                "./assets/images/poem.png"),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              categoryCtrl.text = 'Editorial';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 120,
                                            width: 70,
                                            child: literatureOptionsCard(
                                                "Editorial",
                                                "./assets/images/drama.png"),
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
                controller: content,
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
            GestureDetector(
                onTap: () => pickImage(), child: imageSelectionCard(context)),
            pickedImage != null
                ? Text(pickedImage!.path.split('/').last)
                : const SizedBox.shrink(),
            pickedImage == null
                ? Text(widget.image.toString())
                : const SizedBox.shrink(),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (pickedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please reselect an image")));
                  setState(() {
                    loading = false;
                  });
                  return;
                } else {
                  if (title.text.isNotEmpty &&
                      author.text.isNotEmpty &&
                      categoryCtrl.text.isNotEmpty &&
                      content.text.isNotEmpty) {
                    setState(() {
                      loading = true;
                    });
                  }
                  // get lost data
                  getLostData();
                  editPost(
                      title.text.toString(),
                      categoryCtrl.text.toString(),
                      author.text.toString(),
                      pickedImage == null ? null : pickedImage!.path,
                      content.text.toString(),
                      widget.postId);
                }
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                child: Text(
                  loading ? "Posting... Please wait" : "Submit",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
