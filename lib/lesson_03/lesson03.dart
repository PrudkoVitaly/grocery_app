import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lesson03 extends StatefulWidget {
  const Lesson03({super.key});

  @override
  State<Lesson03> createState() => _Lesson03State();
}

class _Lesson03State extends State<Lesson03> {
  int number = 0;
  String name = "Vitalik";
  bool change = false;
  int numberOne = 0;

  void increment() {
    setState(() {
      number++;
    });
  }

  void changeName() {
    setState(() {
      change = !change;
      name = change ? name.toLowerCase() : name.toUpperCase();
    });
  }

  void plus() {
    setState(() {
      numberOne = 2 + 2;
    });
  }

  int plus2(int a, int b) {
    return a + b;
  }

  String nameFunction({required String name}) {
    return name;
  }

  double numberFunction({double number = 0.0}) {
    return number;
  }

  String? stringFunction({String? string}) {
    return string;
  }

  bool obscureText = true;

  Widget myWidget(
      {required Color myColor, required IconData myIcon}) {
    return Container(
      height: 100,
      width: 100,
      color: myColor,
      child: Center(
        child: Icon(
          myIcon,
          size: 45,
        ),
      ),
    );
  }

  Widget textFieldWidget({
    required IconData prefixIcon,
    required String hintText,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: textInputAction,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("$number"),
                  Text(name),
                  Text("$numberOne"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      increment();
                    },
                    child: Text("data"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changeName();
                    },
                    child: Text("data"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      plus();
                    },
                    child: Text("data"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(nameFunction(name: "Vasya")),
                  Text(nameFunction(name: "Kolya")),
                  Text("$numberOne"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      plus2(2, 2);
                    },
                    child: Text("data"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      plus2(4, 10);
                    },
                    child: Text("data"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      plus2(10, 20);
                    },
                    child: Text("data"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print(numberFunction());
                },
                child: Text("Button"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myWidget(myColor: Colors.green, myIcon: Icons.add),
                  myWidget(
                      myColor: Colors.blue, myIcon: Icons.remove),
                  myWidget(
                      myColor: Colors.cyan,
                      myIcon: Icons.ac_unit_outlined),
                ],
              ),
              const SizedBox(height: 20),
              textFieldWidget(
                  prefixIcon: Icons.email, hintText: "Email"),
              const SizedBox(height: 20),
              textFieldWidget(
                  prefixIcon: Icons.lock,
                  hintText: "Password",
                  obscureText: obscureText,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye))),
            ],
          ),
        ),
      ),
    );
  }
}
