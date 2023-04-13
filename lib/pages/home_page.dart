import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todoList = [];

  @override
  void initState() {
    super.initState();
    todoList.addAll([
      "Buy milk",
      "Buy meat",
      "Buy water",
      "Buy potatoes",
      "Buy cheese",
      "Go to public services",
      "Finish the project",
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("To Do List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.mode_edit_outline),
                trailing: Icon(Icons.delete_sweep, color: Colors.red),
                title: Text(todoList[index]),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
