import 'package:flutter/material.dart';
import 'Videoplayer.dart';

class Playbar extends StatelessWidget {
  //final VideoPlayerScreen _videoPlayer;
  //const Playbar(this._videoPlayer);
  const Playbar({super.key});
  
  @override
  Widget build(BuildContext context)  {
    var buttons = [
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.fast_rewind)
        ),

        ElevatedButton(
          onPressed: () { },
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