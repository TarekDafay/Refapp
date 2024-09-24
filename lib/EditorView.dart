import 'package:flutter/material.dart';

import 'Videoplayer.dart';
import 'Playbar.dart';

class EditorView extends StatelessWidget {
  const EditorView ({super.key});

  Scaffold portraitView(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: <Widget> [
            Row(
              children: [VideoPlayerScreen()
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Playbar()],
            )
          ]
        )
    );
  }

  Scaffold landscapeView(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: <Widget> [
            Row(
              children: [RotatedBox(
                quarterTurns: 1,
                child: VideoPlayerScreen()
                )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
            ),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Playbar()],
            )
            */
          ]
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