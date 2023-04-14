import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _userToDo;
  List todoList = [];

  void initFirebase()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    initFirebase();

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

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text("Menu"),
          // centerTitle: true,
        ),
        body: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: const Text("На главную"),
            ),
            const SizedBox(width: 15),
            const Text("Наше простое меню"),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("To Do List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _menuOpen,
            icon: Icon(Icons.menu_outlined),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Text("No records");
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshot.data!.docs[index].id),
                child: Card(
                  child: ListTile(
                    // leading: Icon(Icons.mode_edit_outline),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_sweep_sharp,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                      },
                    ),
                    title: Text(snapshot.data!.docs[index].get('itemTitle')),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add a note"),
                content: TextField(
                  onChanged: (String value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('items').add({'itemTitle': _userToDo});
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
