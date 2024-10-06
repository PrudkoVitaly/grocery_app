import 'package:flutter/material.dart';

List<String> names = ["Vasya", "Petya", "Vova"];
List<int> ages = [10, 20, 30];
List<double> kg = [0.1, 0.2, 0.3];
List<bool> isMarried = [true, false, true];

List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple
];

List<IconData> widgets = [Icons.add, Icons.remove, Icons.close];
List<Widget> childrenOne = [
  Container(
    width: 100,
    height: 100,
    color: Colors.red,
  ),
  Text("data"),
  Icon(Icons.add),
];

// Todo: CRUD - Create, Read, Update, Delete

void create() {
  print(names);
  // names.add("Kolya");
  names.addAll(["Kolya", "Sergey"]);
  print(names);
}

void delete() {
  print(names);
  // names.remove("Sergey");
  // names.removeAt(4);
  names.clear();
  print(names);
}

void upDate() {
  print(names);
  names[0] = "John";
  print(names);
}

class Lesson_06 extends StatelessWidget {
  const Lesson_06({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            childrenOne[0],
            childrenOne[1],
            childrenOne[2],
            Icon(
              widgets[0],
            ),
            Icon(
              widgets[1],
            ),
            Icon(
              widgets[2],
            ),
            Text(names[0]),
            Text("${names.length}"),
            Text("${names.isEmpty}"),
            Text("${names.reversed}"),
            ElevatedButton(
              onPressed: () {
                create();
              },
              child: Text("Add"),
            ),
            ElevatedButton(
              onPressed: () {
                delete();
              },
              child: Text("Delete"),
            ),
            ElevatedButton(
              onPressed: () {
                upDate();
              },
              child: Text("UpDate"),
            )
          ],
        ),
      ),
    );
  }
}
