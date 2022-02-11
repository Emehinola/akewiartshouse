import 'dart:convert';
import 'package:akewiartshouse/backend/backend.dart';
import 'package:akewiartshouse/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // for loading
  bool loading = false;

  // text fields contoller
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  // for logging in
  Future login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://placid-001-site50.itempurl.com/api/User/login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIzIiwiZW1haWwiOiJvbGFkZXBvb2xhdHVuZGVAZ21haWwuY29tIiwibmJmIjoxNjQ0NDM5MjA2LCJleHAiOjE2NDQ1MjU2MDYsImlhdCI6MTY0NDQzOTIwNn0.8Q62kFcL0CAmg8PAMq8VSnW_9jEvLRIsCZA4MM3l_q7NHG5-MhNQNolE79OxgHRy4gK9tUW37KXIRqJT0wfxAw'
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    // print(response.body);
    return response;
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
                      const Text("Login",
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
                        height: 30,
                      ),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: passwordCtrl,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(
                                CupertinoIcons.lock,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (emailCtrl.text.isNotEmpty &&
                              passwordCtrl.text.isNotEmpty) {
                            setState(() {
                              loading = true;
                            });
                            login(emailCtrl.text, passwordCtrl.text)
                                .then((value) {
                              try {
                                Map<String, dynamic> result =
                                    json.decode(value.body);

                                if (result['status'] == 'success') {
                                  Database.box.putAll({
                                    'isLoggedIn': true,
                                    'authorization': result['data'],
                                    'email': emailCtrl.text
                                  }).then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                NavigationScreen()));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Incorrect username or password")));
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              } catch (e) {
                                // error handling
                              }
                            });
                          } else {
                            //
                          }
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black),
                          child: Text(
                            loading ? "Logging In..." : "Login",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpScreen())),
                        child: const Text("Register Now",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
