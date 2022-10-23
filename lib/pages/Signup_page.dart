import 'dart:convert';

import 'package:assignment/pages/Login_page.dart';
import 'package:assignment/utils/routes.dart';
import 'package:assignment/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({super.key});

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  //String? email, password, phone;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }

  final String url = "https://api.whitewular.com/CustomerRegister";
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (_key.currentState != null) {
      form!.save();
      save();
    }
  }

  save() async {
    Map test = {
      "dob": "dd-mm-yy",
      "emailId": _email.text.toString(),
      "firstName": "first",
      "gender": "M",
      "hobbies": "hello world",
      "lastName": "last",
      "password": _password.text.toString(),
      "phoneNumber": _phone.text.toString(),
      "profession": "student",
      "socialprofile": "student",
      "type": "hello"
    };

    // print(h.runtimeType);
    // print(jsonEncode(test));
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(test));
    final data = jsonDecode(response.body);
    var id = data['id'];
    print(response.body);
    Map<String, dynamic> mark = jsonDecode(response.body);
    print(mark["message"]);
    print(response.statusCode);
    print(test);
    if (mark["message"]=="Success") {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login_Page()),
        );
      });
      print(id);
      registerToast("Register sucessfull");
    } else if (response.statusCode == 400) {
      registerToast("A user with that username already exists");
    } else {
      registerToast("Register fail");
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor:
            toast == "Register sucessfull" ? Colors.green : Colors.red,
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
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                          //onSaved: (e) => email = e,
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
                          validator: (password) {
                            if (password!.isEmpty) {
                              return "Please insert password";
                            }
                          },
                          //onSaved: (e) => password = e,
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
                          height: 15,
                        ),
                        TextFormField(
                          controller: _phone,
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "Please insert phone number";
                            }
                          },
                          //onSaved: (e) => phone = e,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone,
                                  color: Color.fromARGB(255, 68, 68, 68)),
                              contentPadding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: new BorderSide(
                                  color: Color.fromARGB(255, 68, 68, 68),
                                  width: 1.0,
                                ),
                              ),
                              labelText: "Phone Number",
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your Phone Numberr",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 68, 68, 68),
                              )),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            check();
                          },
                          child: AnimatedContainer(
                            width: 120,
                            height: 50,
                            duration: Duration(milliseconds: 500),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                "Sign Up",
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
                              "Already have an account,",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login_Page()),
                                  );
                                },
                                child: Text(
                                  "Login?",
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
      ),
    );
  }
}
