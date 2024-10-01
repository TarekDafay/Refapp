
import 'package:flutter/material.dart';
import 'Toolbar.dart';

class ProjectView extends StatelessWidget {
  Toolbar toolbar;
  ProjectView({super.key}) : toolbar = Toolbar();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbar,
        body: Column(
        children: <Widget> [
          Text(toolbar.video.absolute.path)
      ],

    )
    );
  }
}