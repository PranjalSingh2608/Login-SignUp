import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      titleSpacing: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0),
      ),
    );
  }
}
