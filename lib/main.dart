import 'package:flutter/material.dart';
import 'package:to_do_list_firebase/pages/home_page.dart';
import 'package:to_do_list_firebase/pages/main_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/todo': (context) => const HomePage()
      },
    ));
