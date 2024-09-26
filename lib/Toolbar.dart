import 'package:flutter/material.dart';

class Toolbar extends StatefulWidget implements PreferredSizeWidget {
  Toolbar({Key? key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _ToolbarState createState() => _ToolbarState();

}

class _ToolbarState extends State<Toolbar>  {
  @override
  Widget build(BuildContext context)  {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, // TODO - Add Callback to filemanager
        icon: const Icon(Icons.file_open),
        )
      ],
    );
  }
}