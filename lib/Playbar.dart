import 'package:flutter/material.dart';
import 'package:ref_app/EditorView.dart';
import 'package:video_player/video_player.dart';
import 'Videoplayer.dart';

class Playbar extends StatelessWidget {
  final VideoPlayerController controller;
  const Playbar({super.key, required this.controller});
  
  void playVideo() {controller.play();}
  void pauseVideo() {controller.pause();}

  @override
  Widget build(BuildContext context)  {
    var buttons = [
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.fast_rewind)
        ),

        ElevatedButton(
          onPressed: () { 
            controller.play();
          },
          child: const Icon(Icons.play_arrow)
        ),
          
        ElevatedButton(
          onPressed: () { },
          child: const Icon(Icons.fast_forward)
        ),
      ];
    if(MediaQuery.orientationOf(context) == Orientation.portrait)  {
      return Row(children: buttons);
    }
    return Column(children: buttons);
  }
}