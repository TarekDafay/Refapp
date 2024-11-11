import 'dart:io';
import 'package:ref_app/bloc/FileLoader_bloc.dart';
import 'package:ref_app/bloc/FileLoader_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatefulWidget implements PreferredSizeWidget {
  late File video; 
  Toolbar({Key? key}) : video = File("/123"),preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _ToolbarState createState() => _ToolbarState();

}

class _ToolbarState extends State<Toolbar>  {
  @override
  Widget build(BuildContext context)  {
    print("\n\n\n\n\n\n\n\n");
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print(widget.video.path);
    print("\n\n\n\n\n\n\n\n");

    return AppBar(
      actions: [
        IconButton(onPressed: () async {
          final FilePickerResult? result = await FilePicker.platform.pickFiles();
          setState(() {
          
          if(result != null) {
            PlatformFile pltFile = result.files.single;
            
            widget.video = File(pltFile.path!);
            print(pltFile.path);
          } else  {
            return;
          }
        });
        }, 
        
        icon: const Icon(Icons.file_open),
        ),
        TextButton(
          onPressed: () {
            print("Navigator clicked!!!!");
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