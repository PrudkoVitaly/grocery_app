import 'package:flutter/material.dart';

Map<String, String> person = {
  "name": "John",
  "surname": "Doe",
  "age": "30",
};

Map<int, String> numbers = {
  1: "one",
  2: "two",
  3: "three",
};

Map<String, bool> booleans = {
  "true": true,
  "false": false,
};

Map<String, Color> colors = {
  "red": Colors.red,
  "green": Colors.green,
  "blue": Colors.blue,
};

Map<String, dynamic> products = {
  "name": "Apple",
  "price": 1.99,
  "isAvailable": true,
  "colors": ["red", "green", "blue"],
  "address": {"street": "Main Street", "number": 123},
  "colorProduct": Colors.red
};

class Lesson_08 extends StatefulWidget {
  const Lesson_08({super.key});

  @override
  State<Lesson_08> createState() => _Lesson_08State();
}

class _Lesson_08State extends State<Lesson_08> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: 300,
            height: 300,
            color: colors["red"],
          ),
        ],
      )),
    );
  }
}
