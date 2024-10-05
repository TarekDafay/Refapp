import 'package:flutter/material.dart';
import 'Toolbar.dart';

class ExportView extends StatelessWidget {
  Toolbar toolbar;
  ExportView({super.key}) : toolbar = Toolbar();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(),
      body: Column(
        children: <Widget> [
          Text(toolbar.video.path)
      ]
    ));
  }
}