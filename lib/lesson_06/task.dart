import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<String> tasks = ["Task 1", "Task 2", "Task 3", "Task 4"];
  List<String> tasksEdit = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  TextEditingController controllerEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            margin: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 40,
                  child: Text(
                    "$index",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(tasks[index]),
                subtitle: const Text("Description Task"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return AlertDialog(
                                  title: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                        textAlign: TextAlign.center,
                                        "Do you really want to delete"),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          tasks.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.delete)),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      const Text(
                                          textAlign: TextAlign.center,
                                          "Do you want to edit"),
                                      Text(
                                        textAlign: TextAlign.center,
                                        tasks[index],
                                      ),
                                      TextField(
                                        controller: controllerEdit,
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cansel"),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        tasks[index] =
                                            controllerEdit.text;
                                        controllerEdit.clear();
                                      });
                                      Navigator.pop(context);
                                      if (formKey.currentState!
                                          .validate()) {
                                        setState(() {});
                                      }
                                    },
                                    child: Text("Edit"),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: Form(
                    key: formKey,
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller,
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return "Please Enter Task";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {});
                          tasks.add(controller.text);
                          Navigator.pop(context);
                          controller.clear();
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
