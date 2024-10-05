import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ref_app/bloc/Editor_bloc.dart';
import 'package:ref_app/bloc/Editor_state.dart';
import 'package:video_player/video_player.dart';

import 'Videoplayer.dart';
import 'Playbar.dart';
import 'Toolbar.dart';

class EditorView extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    //VideoPlayerScreen videoPlayer = VideoPlayerScreen(controller: widget.controller);
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
      return Scaffold();//portraitView(context, videoPlayer);
    } else  {
      return BlocListener<EditorBloc, EditorState>(
        listener: (context, state){
      },
      child: landscapeView(context));
      //landscapeView(context, videoPlayer);
    }
      
  }
  /*
  VideoPlayerController controller;
  late VideoPlayerScreen videoplayer;
  
  Toolbar toolbar;
  VideoplayerWindow videoplayer;

  EditorView ({super.key}) : toolbar = Toolbar() ,controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));
  
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
  */
  Scaffold landscapeView(BuildContext context) {
    Toolbar toolbar;
    /*
      if(widget.toolbar.video != null)   {
      widget.controller = VideoPlayerController.file(widget.toolbar.video);
    }
    */
    return Scaffold(
        appBar: Toolbar(),
        body: VideoplayerWindow()
      );
        /*
            children: [
            Expanded(
              child: Column(
                children: [
                  FittedBox(
                  child: VideoplayerWindow()
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
           
        )*/ 
  }
  /*
  @override
  Widget build(BuildContext context)  {
    VideoPlayerScreen videoPlayer = VideoPlayerScreen(controller: widget.controller);
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
      return portraitView(context, videoPlayer);
    } else  {
      return landscapeView(context, videoPlayer);
    }
      
  }
  */
}
