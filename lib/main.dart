import 'package:flutter/material.dart';
import 'package:ref_app/Login.dart';
import 'package:ref_app/toolbar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RefApp',
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}
