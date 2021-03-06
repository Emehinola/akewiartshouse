import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:akewiartshouse/backend/backend.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditLiterature extends StatefulWidget {
  String? title;
  String? author;
  String? category;
  String? content;

  String? image;
  int litId;

  EditLiterature(
      {this.title,
      this.author,
      this.category,
      this.content,
      this.image,
      required this.litId});

  @override
  _EditLiteratureState createState() => _EditLiteratureState();
}

class _EditLiteratureState extends State<EditLiterature> {
  // controllers
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
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
  Future editLiterature(String title, String category, String author, imagePath,
      String content) async {
    try {
      int catId = 0;

      if (category.toLowerCase() == 'poetry') {
        catId = 1;
      } else if (category.toLowerCase() == 'drama') {
        catId = 2;
      } else {
        catId = 3;
      }
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse(
              '${EndPoint.baseUrl}/api/Literature/updateLiterature'));

      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      request.fields.addAll({
        'id': widget.litId.toString(),
        'title': title,
        'postBy': author,
        'contDesc': content,
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
            const SnackBar(content: Text("Literature edited successfully")));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Literature()));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unable to submit post. Try again")));
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }

    // print("response: ${response.body}");
  }

  void initState() {
    _imagePicker = ImagePicker();
    _imagePicker = ImagePicker();
    categoryCtrl.text = widget.category.toString();
    title.text = widget.title.toString();
    author.text = widget.author.toString();
    description.text = widget.content.toString();
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
          "Edit literature post",
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
                controller: description,
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
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;
                });

                if (pickedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please reselect an image")));
                  setState(() {
                    loading = false;
                  });
                  return;
                }

                if (title.text.isNotEmpty &&
                    author.text.isNotEmpty &&
                    categoryCtrl.text.isNotEmpty &&
                    description.text.isNotEmpty) {
                  editLiterature(
                      title.text.toString(),
                      categoryCtrl.text.toString(),
                      author.text.toString(),
                      pickedImage!.path,
                      description.text.toString());
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
