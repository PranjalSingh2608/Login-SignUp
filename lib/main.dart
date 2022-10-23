import 'package:assignment/pages/Home_page.dart';
import 'package:assignment/pages/Login_page.dart';
import 'package:assignment/pages/Signup_page.dart';
import 'package:assignment/utils/routes.dart';
import 'package:assignment/widgets/share.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   var isLogin;

  checkUserLoginState() async {
    await Shared.getUserSharedPrefernces().then(
      (value) {
        setState(() {
          isLogin = value;
        });
      },
    );
  }

  void iniState() {
    checkUserLoginState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
              ),
        ),
      ),
      initialRoute:"/signup",     
      routes: {
        MyRoutes.SignUpRoute: ((context) => SignUp_Page()),
        MyRoutes.HomeRoute: ((context) => Home_Page()),
        MyRoutes.LoginRoute: ((context) => Login_Page())
      },
    );
  }
}


