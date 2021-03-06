import 'dart:convert';
import 'dart:io';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:file_picker/file_picker.dart';
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
class MusicUploadScreen extends StatefulWidget {
  @override
  _MusicUploadState createState() => _MusicUploadState();
}

class _MusicUploadState extends State<MusicUploadScreen> {
// controlllers
  TextEditingController author = TextEditingController();
  TextEditingController musicTitle = TextEditingController();
  TextEditingController artistName = TextEditingController();

  // loading controller
  bool loading = false;

  // IMAGE
  File? pickedImage;
  ImagePicker? _imagePicker;

  // Audio
  File? pickedAudio;

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

  void pickAudio() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.audio);
    setState(() {
      pickedAudio =
          result!.paths.map((path) => File(path.toString())).toList()[0];
    });
    print(pickedAudio!.path);
  }

  // posting article
  Future uploadMusic(String author, String artistName, String musicTitle,
      imagePath, musicPath) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${EndPoint.baseUrl}/api/Music/createMusic'));

      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      request.files
          .add(await http.MultipartFile.fromPath('musicPath', imagePath));

      request.fields.addAll({
        'postedby': author,
        'musicPath': musicPath,
        'artistName': artistName,
        'musicTitle': musicTitle,
        'image': imagePath,
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
            const SnackBar(content: Text("Music uploaded successfully")));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Music()));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unable to post music. Try again")));
      }
    } catch (error) {
      print('error: $error');
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
          "Upload new song",
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
                controller: author,
                decoration: InputDecoration(
                    hintText: "Your name",
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
                controller: artistName,
                decoration: InputDecoration(
                    hintText: "Artist name",
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
                controller: musicTitle,
                decoration: InputDecoration(
                    hintText: "Song title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select album image",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
                onTap: () => pickImage(), child: imageSelectionCard(context)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select music",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            pickedImage != null
                ? Text(pickedImage!.path.split('/').last)
                : const SizedBox.shrink(),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
                onTap: () => pickAudio(),
                child: imageSelectionCard(context, 'Select music here')),
            const SizedBox(
              height: 20,
            ),
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
                  // getLostData();
                  uploadMusic(
                      author.text.toString(),
                      artistName.text.toString(),
                      musicTitle.text.toString(),
                      pickedImage!.path,
                      pickedAudio!.path);
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
