import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class EmailConfirmationScreen extends StatefulWidget {
  @override
  _EmailConfirmationScreenState createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  TextEditingController emailCtrl = TextEditingController();
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
                          "Enter the 5-digit verification code sent that was sent to your email",
                          textAlign: TextAlign.center,
                          style: TextStyle()),
                      const SizedBox(
                        height: 50,
                      ),
                      PinCodeTextField(
                        autofocus: true,
                        controller: emailCtrl,
                        hideCharacter: true,
                        highlight: true, pinBoxColor: Colors.white70,
                        highlightColor: Colors.black54,
                        defaultBorderColor: Colors.transparent,
                        hasTextBorderColor: Colors.transparent,
                        highlightPinBoxColor: Colors.white70,
                        maxLength: 5,
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
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.black),
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
