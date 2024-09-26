import 'package:flutter/material.dart';
import 'package:ref_app/EditorView.dart';
import 'package:video_player/video_player.dart';
import 'Videoplayer.dart';


class Playbar extends StatefulWidget {
  final VideoPlayerController controller;
  Playbar({super.key, required this.controller});

  @override
  State<Playbar> createState() => PlaybarState();
}

class PlaybarState extends State<Playbar> {
  bool isPlaying = false;
  void playVideo() {widget.controller.play();}
  void pauseVideo() {widget.controller.pause();}

  @override
  Widget build(BuildContext context)  {
    var buttons = [
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.fast_rewind)
        ),
        
        ElevatedButton(
        onPressed: () {setState(() { 
        widget.controller.value.isPlaying
                  ? pauseVideo()
                  : playVideo();
        },
        );
        },
            child: Icon(!widget.controller.value.isPlaying ? Icons.play_arrow : Icons.pause),
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