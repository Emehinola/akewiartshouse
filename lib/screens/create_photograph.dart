import 'package:akewiartshouse/custom_widgets.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:akewiartshouse/backend/backend.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreatePhotograph extends StatefulWidget {
  @override
  _CreatePhotographState createState() => _CreatePhotographState();
}

class _CreatePhotographState extends State<CreatePhotograph> {
  // controllers
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController author = TextEditingController();

  // loading controller
  bool loading = false;

  // IMAGE
  List<File>? pickedImages;
  ImagePicker? _imagePicker;

  // get lost data
  // getLostData() async {
  //   final LostDataResponse response = await _imagePicker!.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     setState(() {
  //       pickedImages = File(response.file!.path);
  //       //
  //     });
  //   } else {
  //     //
  //   }
  // }

  // pick image to upload
  pickImage() async {
    var pickedFiles = await _imagePicker!.pickMultiImage();
    setState(() {
      pickedImages = List.generate(
          pickedFiles!.length, (index) => File(pickedFiles[index].path));
      // print("picked: $pickedImage");
    });
  }

  // posting article
  Future uploadPhotos(String title, String category, String author, imagePaths,
      String content) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('${EndPoint.baseUrl}/api/Photography/createPhotography'));

      request.files.add(await http.MultipartFile.fromPath('mainImage',
          imagePaths[0].path)); // sets the first image as the main image
      imagePaths.removeAt(0); // removes the main image

      for (var i = 0; i < imagePaths!.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('photos', imagePaths[i].path));
      }

      request.fields.addAll({
        'title': title,
        'description': content,
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
            const SnackBar(content: Text("Photos uploaded successfully")));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ArtWork()));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Unable to upload photos. Try again")));
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      print("{erro: $error}");
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
          "Upload photos",
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
              "Select multiple images",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
                onTap: () => pickImage(), child: imageSelectionCard(context)),
            pickedImages != null
                ? Text("${pickedImages!.length} images selected")
                : const SizedBox.shrink(),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;
                });

                uploadPhotos(
                    title.text.toString(),
                    categoryCtrl.text.toString(),
                    author.text.toString(),
                    pickedImages,
                    description.text.toString());
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                child: Text(
                  loading ? "Uploading... Please wait" : "Upload",
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
