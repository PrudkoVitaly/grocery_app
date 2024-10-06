import 'package:flutter/material.dart';

class Lesson_02 extends StatefulWidget {
  const Lesson_02({super.key});

  @override
  State<Lesson_02> createState() => _Lesson_02State();
}

class _Lesson_02State extends State<Lesson_02> {
  String data = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Center(
              child: Text("No Data"),
            )
          : Center(
              child: Text(data),
            ),
    );
  }
}
