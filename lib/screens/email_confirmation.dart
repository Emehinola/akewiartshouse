import 'dart:convert';

import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class EmailConfirmationScreen extends StatefulWidget {
  String? email;

  EmailConfirmationScreen({this.email});

  @override
  _EmailConfirmationScreenState createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  TextEditingController codeCtrl = TextEditingController();
  bool loading = false;

  // email verifivation
  Future verifyEmail(String email, String code) async {
    var response = await http.post(
        Uri.parse('http://placid-001-site50.itempurl.com/api/User/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}));

    try {
      var result = json.decode(response.body);

      if (result['status'] == 'success') {
        setState(() {
          loading = false;
        });
        Database.box.putAll({'email': email}).then((value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen())));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result['message'])));
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child:
                              Image.asset('./assets/images/email_image.png')),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Verify Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 21)),
                      const Text(
                          "Enter the 6-digit verification code sent that was sent to your email",
                          textAlign: TextAlign.center,
                          style: TextStyle()),
                      const SizedBox(
                        height: 50,
                      ),
                      PinCodeTextField(
                        autofocus: true,
                        controller: codeCtrl,
                        hideCharacter: true,
                        highlight: true, pinBoxColor: Colors.white70,
                        highlightColor: Colors.black54,
                        defaultBorderColor: Colors.transparent,
                        hasTextBorderColor: Colors.transparent,
                        highlightPinBoxColor: Colors.white70,
                        maxLength: 6,
                        hasError: false,
                        maskCharacter: "😎",
                        onTextChanged: (text) {
                          setState(() {});
                        },
                        onDone: (text) {},
                        pinBoxWidth: 45,
                        pinBoxHeight: 45,
                        hasUnderline: false,
                        wrapAlignment: WrapAlignment.spaceAround,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: const TextStyle(fontSize: 22.0),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          if (codeCtrl.text.length == 6) {
                            setState(() {
                              loading = true;
                            });
                            verifyEmail(widget.email.toString(),
                                codeCtrl.text.toString());
                          } else {
                            // TODO
                          }
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black),
                          child: Text(
                            loading ? "Verifying..." : "Verify",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
