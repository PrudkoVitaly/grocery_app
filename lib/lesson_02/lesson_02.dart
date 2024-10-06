// TODO variables (примитивные типы данных)
import 'package:flutter/material.dart';

String name = "Vitalik";
int age = 30;
// double height = 1.80;
bool isMarried = false;

// TODO Flutter variables
Widget icon = const Icon(Icons.add);
Color white = Colors.white;
Container square = Container(
  width: 100,
  height: 100,
);

double width = 120;
double height = 120;
Color color = Colors.red;
int number = 0;
bool like = false;

Widget container = Container(
  width: 120,
  height: 120,
  color: Colors.green,
);

class Lesson02 extends StatefulWidget {
  const Lesson02({super.key});

  @override
  State<Lesson02> createState() => _Lesson02State();
}

class _Lesson02State extends State<Lesson02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Text(name),
            Text("${name.length} - Length"),
            Text("${name.isEmpty}"),
            Text("${name.isNotEmpty}"),
            Text("$age"),
            Text("${age.isOdd}"),
            Text("${age.isEven}"),
            Text("${age.isNaN}"),
            Text("$isMarried"),
            Text("${isMarried.runtimeType}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.green,
                ),
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.yellow,
                ),
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: width,
            //       height: height,
            //       color: Colors.green,
            //     ),
            //     Container(
            //       width: width,
            //       height: height,
            //       color: Colors.yellow,
            //     ),
            //     Container(
            //       width: width,
            //       height: height,
            //       color: Colors.red,
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                container,
                container,
                container,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$number"),
                Text(name),
                Text("3"),
              ],
            ),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         setState(() {
            //           number++;
            //         });
            //       },
            //       child: const Text("+"),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         setState(() {
            //           name = name.toLowerCase();
            //         });
            //       },
            //       child: const Text("name"),
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         setState(() {
            //           like = !like;
            //         });
            //       },
            //       icon: like
            //           ? const Icon(
            //               Icons.favorite,
            //               color: Colors.red,
            //             )
            //           : const Icon(Icons.favorite_border),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
