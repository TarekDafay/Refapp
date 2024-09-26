import 'dart:io';
import 'package:matcher/matcher.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoPlayerController controller;
  VideoPlayerScreen({super.key, required this.controller});

  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late Future<void> _initializeVideoPlayerFuture; 

  @override
  void initState()  {
    super.initState();
    _initializeVideoPlayerFuture = widget.controller.initialize();
  }

  @override
  void dispose()  {
    widget.controller.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    double videoWidth = MediaQuery.orientationOf(context)== Orientation.portrait ? MediaQuery.sizeOf(context).width : MediaQuery.sizeOf(context).height;//MediaQuery.sizeOf(context).height * controller.value.aspectRatio; 
    return SizedBox(
      width: videoWidth,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture, 
        builder: (context, snapshot)  {
          // If Videoplayer is initialized
          if(snapshot.connectionState == ConnectionState.done)  {
              return AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
                );
          }
          // If Videoplayer is still initializing
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        ),

        /*
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Wrap Play/Pause Button in call to `setState`
            setState(() {
              if(controller.value.isPlaying) {
                controller.pause();
              } else  {
                controller.play();
              }
            });
          },
          child: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow
            ),
          ),
          */
    );
  }

}