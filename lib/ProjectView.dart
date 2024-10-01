
import 'package:flutter/material.dart';
import 'Toolbar.dart';
import 'ProjectList.dart';


class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(),
      body: ProjectList()
    );
  }
}