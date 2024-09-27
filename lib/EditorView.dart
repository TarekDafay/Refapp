import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Videoplayer.dart';
import 'Playbar.dart';
import 'Toolbar.dart';

class EditorView extends StatelessWidget {
  VideoPlayerController controller;
  late VideoPlayerScreen videoplayer;
  EditorView ({super.key}) : controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

  Scaffold portraitView(BuildContext context, VideoPlayerScreen videoPlayer) {
    controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));
    return Scaffold(
        appBar: Toolbar(),
        body: Column(
          children: <Widget> [
            Row(
              children: [videoPlayer
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Playbar(controller: controller,)],
            ),
          ]
        )
    );
  }

  Scaffold landscapeView(BuildContext context, VideoPlayerScreen videoPlayer) {
    controller = VideoPlayerController.networkUrl(
    Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));
    return Scaffold(
        appBar: Toolbar(),
        body: Row(
            children: [
            Expanded(
              child: Column(
                children: [
                  RotatedBox(
                  quarterTurns: 0,
                  child: videoPlayer
              ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Playbar(controller: controller)],
              ),
            ),
            ],
        )
      );
  }

  @override
  Widget build(BuildContext context)  {
    VideoPlayerScreen videoPlayer = VideoPlayerScreen(controller: controller);
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
      return portraitView(context, videoPlayer);
    } else  {
      return landscapeView(context, videoPlayer);
    }
      
  }
}
