import 'package:flutter/material.dart';

class Lesson_12 extends StatelessWidget {
  const Lesson_12({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            divide();
          },
          child: Text("Click"),
        ),
      ),
    );
  }

  // void divide() {
  //   try {
  //     int result = divideNumbers(10, 0);
  //     print("Result: $result");
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  int divideNumbers(int a, int b) {
    return a ~/ b;
  }

  void divide() {
    try {
      int result = divideNumbers(10, 0);
      print("Result: $result");
    } on IntegerDivisionByZeroException {
      print("Error: it can't divide by zero");
    } on FormatException {
      print("Error: error format");
    } catch (e) {
      print("$e Error");
    }
  }
}

class AsyncAwait extends StatelessWidget {
  const AsyncAwait({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await for (var i in asyncNumberGenerator()) {
                print("Полученно число $i");
              }
            },
            child: Text("Click"),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    print("Начало запроса");
    await Future.delayed(
      Duration(seconds: 3),
    );
    print("Конец запроса");
  }

  Stream<int> asyncNumberGenerator() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}
