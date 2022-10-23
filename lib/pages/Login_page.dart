import 'dart:convert';

import 'package:assignment/pages/Home_page.dart';
import 'package:assignment/utils/routes.dart';
import 'package:assignment/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  final String urllogin = "https://api.whitewular.com/login";
  final _key = new GlobalKey<FormState>();
  bool visible = true;

  login() async {
    setState(() {
      visible = true;
    });
    String email = _email.text;
    String password = _password.text;

    Map check = {
      "emailIdOrPhone": _email.text.toString(),
      "password": _password.text.toString(),
      "sessionKey": "check"
    };
    final response = await http.post(Uri.parse(urllogin),
        headers: {"Content-Type": "application/json"},
        body: json.encode(check));

    final data = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map["message"]);
    print(check);
    if (map["message"]=="Success") {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()),
        );
      });
      loginToast("Login Sucessfull");
    } else if (response.statusCode == 400) {
      loginToast("Email or password is not correct");
    } else {
      loginToast("Login Failed");
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor:
            toast == "Login Sucessfull" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56), child: MyAppBar()),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset("assets/animations/login.json"),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "Please insert email address";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity,
                                color: Color.fromARGB(255, 68, 68, 68)),
                            contentPadding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Color.fromARGB(255, 68, 68, 68),
                                width: 1.0,
                              ),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter your Email",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 68, 68, 68),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,
                                color: Color.fromARGB(255, 68, 68, 68)),
                            contentPadding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Color.fromARGB(255, 68, 68, 68),
                                width: 1.0,
                              ),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter your Password",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 68, 68, 68),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: AnimatedContainer(
                          width: 120,
                          height: 50,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: const Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account,",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.SignUpRoute);
                              },
                              child: Text(
                                "SignUp?",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
