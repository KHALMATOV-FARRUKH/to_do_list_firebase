import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("To Do List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Main Screen", style: TextStyle(color: Colors.white)),
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/todo');
            },
            child: Text("Send to next"),
          ),
        ],
      ),
    );
  }
}
