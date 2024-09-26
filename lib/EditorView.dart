import 'package:flutter/material.dart';

import 'Videoplayer.dart';
import 'Playbar.dart';

class EditorView extends StatelessWidget {
  const EditorView ({super.key});

  Scaffold portraitView(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget> [
            Row(
              children: [VideoPlayerScreen()
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Playbar()],
            ),
            Container (child: Text("$width"),
            ),
            Container (child: Text("$height"),
            ),
          ]
        )
    );
  }

  Scaffold landscapeView(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(),
        body: const Row(
            children: [
            Expanded(
              child: Column(
                children: [
                  RotatedBox(
                  quarterTurns: 0,
                  child: VideoPlayerScreen()
              ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            ),
            Expanded(
              child: Column(
                children: [Playbar()],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            ],
        )
        );
  }

  @override
  Widget build(BuildContext context)  {
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
      return portraitView(context);
    } else  {
      return landscapeView(context);
    }
      
  }
}