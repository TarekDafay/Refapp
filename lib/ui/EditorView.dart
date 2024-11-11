import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ref_app/bloc/Editor_bloc.dart';
import 'package:ref_app/bloc/Editor_state.dart';

import 'package:video_player/video_player.dart';
import '../bloc/videoplayer_bloc.dart';

import 'Videoplayer.dart';
import '../bloc/videoplayer_state.dart';
import '../bloc/videoplayer_event.dart';
import 'Playbar.dart';
import 'Toolbar.dart';

class EditorView extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    //VideoPlayerScreen videoPlayer = VideoPlayerScreen(controller: widget.controller);
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
        return BlocListener<EditorBloc, EditorState>(
        listener: (context, state){
      },
      child: portraitView(context));
    } else  {
      return BlocListener<EditorBloc, EditorState>(
        listener: (context, state){
      },
      child: landscapeView(context));
      //landscapeView(context, videoPlayer);
    }
      
  }

  Scaffold portraitView(BuildContext context) {
    late VideoPlayerController controller; 
    var state = BlocProvider.of<VideoPlayerBloc>(context).state;
    if(state is VideoPlayerLoaded)  {
      controller = (state as VideoPlayerLoaded).controller;
    } else  {
      return Scaffold(
        appBar: Toolbar(),
        body: Center(child: Text(state.toString()))
      );        
    }
    return Scaffold(
        appBar: Toolbar(),
        body: Container(
          child: Center(
            child: LayoutBuilder( 
              builder: (BuildContext context, BoxConstraints constraints) { 
                double aspectRatio = controller.value.aspectRatio;
                var size = controller.value.size.width;
                bool isInit = controller.value.isInitialized;
                double height = constraints.maxHeight; 
                double width = constraints.maxWidth; 
                return Column(
                  children: [
                Row(
                  children: [
                    SizedBox(
                      width: width,
                      height: width * aspectRatio,
                      child: VideoplayerWindow()
                    ) 
                  ],
                ),
                Row(
                  children: [
                    Text("The aspect ratio is $size\n Videoplayer is initialized " + state.toString())
                  ],
                )
                ]
                );
                //return Text("The height of the container is $height"); 
              }, 
            ), 
          ), 
          ),
        );
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
        body: Container(
          child: Center(
            child: LayoutBuilder( 
              builder: (BuildContext context, BoxConstraints constraints) { 
                double height = constraints.maxHeight; 
  
                return Text("The height of the container is $height"); 
              }, 
            ), 
          ), 
          ),
        );
        /*
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
