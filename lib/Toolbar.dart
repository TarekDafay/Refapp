import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatefulWidget implements PreferredSizeWidget {
  String videopath; 
  Toolbar({Key? key}) : videopath = "",preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

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
        IconButton(onPressed: () async {
          final result = await FilePicker.platform.pickFiles();
          if(result == null)  return;

          final file = result.files.first;
          widget.videopath = file.path.toString();
        }, // TODO - Add Callback to filemanager
        icon: const Icon(Icons.file_open),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/project");
          },
          child: Text("Project")
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/editor");
          },
          child: Text("Editor")
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/export");
          },
          child: Text("Export")
        ),
      ],
    );
  }
}