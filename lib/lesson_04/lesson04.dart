import 'package:flutter/material.dart';

class Lesson04 extends StatefulWidget {
  const Lesson04({super.key});

  @override
  State<Lesson04> createState() => _Lesson04State();
}

class _Lesson04State extends State<Lesson04> {
  // TODO: ==, !=, >, <, >=, <=, &&, ||
  void one() {
    if (false) {
      print("True");
    } else {
      print("False");
    }
  }

  void two() {
    if (2 == 2) {
      print("4");
    } else {
      print("3");
    }
  }

  void three() {
    if (2 != 2) {
      print("4");
    } else if (3 == 3) {
      print("6");
    } else {
      print("5");
    }
  }

  void four() {
    if (2 == 2) {
      print("4");
    }
    if (3 == 3) {
      print("6");
    }
  }

  void five() {
    if (2 == 2 && 3 == 3) {
      print("4 and 6");
    }
    if (2 == 2 || 3 == 4) {
      print("4 or 6");
    }
  }

  void six(int a, int b) {
    if (a == b) {
      print("a = b");
    } else if (a > b) {
      print("a > b");
    } else if (a < b) {
      print("a < b");
    } else {
      print("Error");
    }
  }

  String email = "vasy@gmail.com";
  TextEditingController emailController = TextEditingController();

  void login() {
    if (email == emailController.text) {
      print("Success");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This Email is not valid"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                one();
                two();
                three();
                four();
                six(2, 3);
              },
              child: Text("If"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
