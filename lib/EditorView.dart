import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Videoplayer.dart';
import 'Playbar.dart';
import 'Toolbar.dart';

class EditorView extends StatefulWidget {
  VideoPlayerController controller;
  late VideoPlayerScreen videoplayer;
  Toolbar toolbar;

  EditorView ({super.key}) : toolbar = Toolbar() ,controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

  _EditorState createState() => _EditorState();
}

class _EditorState extends State<EditorView> {

  @override
  void initState() {
    super.initState();
  }

  Scaffold portraitView(BuildContext context, VideoPlayerScreen videoPlayer) {
    if(widget.toolbar.video != null)   {
      widget.controller = VideoPlayerController.file(widget.toolbar.video);
    }
    return Scaffold(
        appBar: widget.toolbar,
        body: Column(
          children: <Widget> [
            Row(
              children: [videoPlayer
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Playbar(controller: widget.controller,)],
            ),
          ]
        )
    );
  }

  Scaffold landscapeView(BuildContext context, VideoPlayerScreen videoPlayer) {
      if(widget.toolbar.video != null)   {
      widget.controller = VideoPlayerController.file(widget.toolbar.video);
    }

    print("\n\n\n\n\n\n\n\n");
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("videoplayer:"  + widget.toolbar.video.path);
    print("\n\n\n\n\n\n\n\n");

    return Scaffold(
        appBar: widget.toolbar,
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
                  Column(
              children: <Widget> [
                Text(widget.toolbar.video.path)
            ]
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Playbar(controller: widget.controller)],
              ),
            ),
            ],
        )
      );
  }

  @override
  Widget build(BuildContext context)  {
    VideoPlayerScreen videoPlayer = VideoPlayerScreen(controller: widget.controller);
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
      return portraitView(context, videoPlayer);
    } else  {
      return landscapeView(context, videoPlayer);
    }
      
  }
}
