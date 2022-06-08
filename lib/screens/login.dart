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

  // password obscurring
  bool showPassword = false;

  // for logging in
  Future login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${EndPoint.baseUrl}/api/User/login'),
      headers: {'Content-Type': 'application/json'},
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
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(
                                CupertinoIcons.mail,
                                color: Colors.black,
                                size: 20,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: passwordCtrl,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(bottom: 30),
                              prefixIcon: const Icon(
                                CupertinoIcons.lock,
                                color: Colors.black,
                                size: 20,
                              ),
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    showPassword
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                    size: 15,
                                  ))),
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
                                    'authorization': result['data']['token'],
                                    'username': result['data']['username'],
                                    'email': emailCtrl.text.toString(),
                                    'userId': result['data']['id'],
                                    'password': passwordCtrl.text.toString(),
                                    'fullname':
                                        '${result['data']['firstname']} ${result['data']['lastname']}',
                                    'phone': result['data']['phonenumber']
                                  }).then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.pushReplacement(
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
                                setState(() {
                                  loading = false;
                                });
                                const SnackBar(
                                    content: Text(
                                        "Something went wrong. Please retry"));
                              }
                            });
                          } else {
                            const SnackBar(
                                content: Text("Please fill all fields"));
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailInput())),
                            child: const Text("Forgot Password?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ))
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
