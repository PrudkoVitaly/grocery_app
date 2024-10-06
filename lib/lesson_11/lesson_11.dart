import 'package:flutter/material.dart';

class Lesson_11 extends StatelessWidget {
  final String name;
  Lesson_11({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${athlete.name}"),
            ElevatedButton(
              onPressed: introduce,
              child: Text("Get"),
            ),
          ],
        ),
      ),
    );
  }

  final Athlete athlete = Athlete(
    name: "John",
    surname: "Doe",
    age: 32,
    sport: "Runner",
  );

  void introduce() {
    athlete.introduce();
  }
}

class Person {
  final String name;
  final String surname;
  final int age;

  Person({
    required this.name,
    required this.surname,
    required this.age,
  });

  void introduce() {
    print("Hello, my name is $name $surname and I'm $age years old");
  }

  void walk() {
    print("$name $surname is working");
  }
}

class Athlete extends Person {
  final String sport;

  Athlete(
      {required name,
      required surname,
      required age,
      required this.sport})
      : super(
          name: name,
          surname: surname,
          age: age,
        );

  @override
  void introduce2() {
    super.introduce();
    print("I play $sport");
  }

  void run() {
    super.walk();
  }
}

final athlete = Athlete(
  name: "John",
  surname: "Doe",
  age: 30,
  sport: "Soccer",
);
