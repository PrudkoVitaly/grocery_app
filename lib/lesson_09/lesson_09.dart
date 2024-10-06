import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_09/detail_screen.dart';

// class Product {
//   final bool like;
//   final String image;
//   final String name;
//   final double price;
//
//   Product(this.like, this.image, this.name, this.price);
// }

// Product iphone = Product(
//   false,
//   "image",
//   "Iphone 15",
//   5000,
// );
// Product2 android = Product2(
//   like: false,
//   image: "image",
//   name: "Android 10",
//   price: 3000,
// );

// class Student {
//   final String name;
//   final String surname;
//   final int age;
//   final int course;
//
//   Student({
//     required this.name,
//     required this.surname,
//     required this.age,
//     this.course = 1,
//   });
// }
//
// class Person {
//   final String name;
//   final String surname;
//   final int age;
//   final String? education;
//
//   Person({
//     required this.name,
//     required this.surname,
//     required this.age,
//     this.education,
//   });
// }
//
// Student vitalik = Student(
//   name: "Vitalik",
//   surname: "surname",
//   age: 33,
//   course: 3,
// );
//
// List<String> names = ["Vasya", "Petya", "Vova"];

class Product2 {
  final bool like;
  final String image;
  final String name;
  final double price;

  Product2(
      {required this.like,
      required this.image,
      required this.name,
      required this.price});
}

List<Product2> products = [
  Product2(
    like: false,
    image: "image",
    name: "Iphone 15",
    price: 5000,
  ),
  Product2(
    like: false,
    image: "image",
    name: "Android 10",
    price: 3000,
  ),
];

class Lesson09 extends StatefulWidget {
  const Lesson09({super.key});

  @override
  State<Lesson09> createState() => _Lesson09State();
}

class _Lesson09State extends State<Lesson09> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products[index].name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen2(
                      product: products[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
