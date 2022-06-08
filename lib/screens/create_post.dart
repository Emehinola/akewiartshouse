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
class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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

  // post categories
  List<String> postCategories = ["Politics", "Literature", "Editorial"];
  List<String> subCategoriesList = ["Essay", "Drama", "Poetry"];

  // sub-category
  String selectedCategory = "Politics";
  String selectedSubCategory = "Drama";

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
  Future createPost(String title, String category, String author, imagePath,
      String content) async {
    try {
      int catId = 0;
      if (selectedCategory.toLowerCase() == 'poetry') {
        catId = 1;
      } else if (selectedCategory.toLowerCase() == 'drama') {
        catId = 2;
      } else {
        catId = 3;
      }
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(category.toLowerCase() == 'politics'
              ? category.toLowerCase() == 'literature'
                  ? '${EndPoint.baseUrl}/api/Literature/createLiterature'
                  : '${EndPoint.baseUrl}/api/Politics/createPolitics'
              : '${EndPoint.baseUrl}/api/Editorial/createEditorial'));

      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      request.fields.addAll({
        'title': title,
        'postedby': author,
        'description': content,
        'catId': catId.toString(),
        'userId': Database.box.get('userId').toString()
      });
      request.headers['Authorization'] =
          'Bearer ${Database.box.get('authorization')}';

      var response = await request.send();
      print('response: ${response.statusCode}');

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post created successfully")));
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
          "Create new post",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: author,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: "Author",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              value: selectedCategory,
              icon: const Icon(CupertinoIcons.chevron_down),
              items: postCategories
                  .map((text) => DropdownMenuItem<String>(
                        child: Text(text),
                        value: text,
                      ))
                  .toList(),
              onChanged: (String? category) {
                setState(() {
                  selectedCategory = category.toString();
                });
              },
            ),
            SizedBox(
              height: selectedCategory == 'Literature' ? 20 : 0,
            ),
            Visibility(
              visible: selectedCategory == 'Literature',
              child: DropdownButton(
                value: selectedSubCategory,
                icon: const Icon(CupertinoIcons.chevron_down),
                items: subCategoriesList
                    .map((text) => DropdownMenuItem<String>(
                          child: Text(text),
                          value: text,
                        ))
                    .toList(),
                onChanged: (String? subCat) {
                  setState(() {
                    selectedSubCategory = subCat.toString();
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: content,
                minLines: 8,
                maxLines: 9,
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
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (!loading && pickedImage != null) {
                  setState(() {
                    loading = true;
                  });
                  // get lost data
                  getLostData();
                  createPost(
                      title.text.toString(),
                      categoryCtrl.text.toString(),
                      author.text.toString(),
                      pickedImage!.path,
                      content.text.toString());
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
