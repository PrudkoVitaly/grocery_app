import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_05/screens/login_screen.dart';
import 'package:flutter_with_bay/lesson_06/lesson_06.dart';
import 'package:flutter_with_bay/lesson_06/task.dart';
import 'package:flutter_with_bay/lesson_07/lesson_07.dart';
import 'package:flutter_with_bay/lesson_08/lesson_08.dart';
import 'package:flutter_with_bay/lesson_08/products_screen.dart';
import 'package:flutter_with_bay/lesson_09/lesson_09.dart';
import 'package:flutter_with_bay/lesson_10/lesson_10.dart';
import 'package:flutter_with_bay/lesson_11/lesson_11.dart';
import 'package:flutter_with_bay/lesson_12/lesson_12.dart';
import 'package:flutter_with_bay/lesson_13/presentation/screens/home_screen.dart';
import 'package:flutter_with_bay/lesson_13/presentation/screens/main_screen.dart';



import 'lesson_13/presentation/screens/detail_screen.dart';
import 'practis_screen/custom_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BankAcountScreen(),
      // home: FitnessScreen(),
      // home: MainScreen(),
      home: HomeScreen(),
    );
  }
}
