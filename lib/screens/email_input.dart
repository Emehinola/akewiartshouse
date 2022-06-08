import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class EmailInput extends StatefulWidget {
  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  // for loading
  bool loading = false;

  // text fields contoller
  TextEditingController emailCtrl = TextEditingController();

  // for requesting password reset
  Future sendPassword(String email) async {
    final response = await http.post(
      Uri.parse('${EndPoint.baseUrl}/api/User/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    // print(response.body);
    try {
      var result = json.decode(response.body);
      if (result['status'] == 'success') {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result['message'])));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
          .showSnackBar(const SnackBar(content: Text('Something went wrong!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Image.asset('./assets/images/login_image.png')),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Forgot Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 21)),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                              hintText: "Email Address",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(
                                CupertinoIcons.mail,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            loading = false;
                          });
                          if (EmailValidator.validate(
                              emailCtrl.text.toString())) {
                            setState(() {
                              loading = true;
                            });
                            sendPassword(emailCtrl.text.toString());
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
                            loading ? "Requesting..." : "Reset Password",
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
