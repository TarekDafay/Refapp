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
  void seekForward(int sec) { 
    Duration nextPos = widget.controller.value.position - Duration(seconds: sec);
    if(nextPos <= widget.controller.value.duration)  {
      widget.controller.seekTo(widget.controller.value.position + Duration(seconds: sec));
    } else  {
      widget.controller.seekTo(widget.controller.value.duration);
    }  
  }

  void seekBackward(int sec) {
    Duration nextPos = widget.controller.value.position - Duration(seconds: sec);
    if(nextPos >= const Duration(seconds: 0))  {
      widget.controller.seekTo(widget.controller.value.position - Duration(seconds: sec));
    } else  {
      widget.controller.seekTo(const Duration(seconds: 0));
    }
  }

  @override
  Widget build(BuildContext context)  {
    var buttons = [
        ElevatedButton(
          onPressed: () { setState(() {
            seekBackward(30);
          });},
          child: const Icon(Icons.replay_30)
        ),
        ElevatedButton(
          onPressed: () { setState(() {
            seekBackward(10);
          });},
          child: const Icon(Icons.replay_10)
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
          onPressed: () { setState(() {
            seekForward(10);
          }); },
          child: const Icon(Icons.forward_10)
        ),
        ElevatedButton(
          onPressed: () { setState(() {
            seekForward(30);
          }); },
          child: const Icon(Icons.forward_30)
        ),
      ];
    if(MediaQuery.orientationOf(context) == Orientation.portrait)  {
      return Row(children: buttons);
    }
    return Column(children: buttons);
  }
}