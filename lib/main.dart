import 'package:flutter/material.dart';

import 'EditorView.dart';
import 'ExportView.dart';
import 'ProjectView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Counter',
            initialRoute: '/project',
      routes: {
        '/project': (context) => ProjectView(),
        '/editor': (context) => EditorView(),
        '/export': (context) => ExportView(),
      },
    );
  }
}
