import 'package:flutter/material.dart';
import 'Videoplayer.dart';

class Playbar extends StatelessWidget {
  //final VideoPlayerScreen _videoPlayer;
  //const Playbar(this._videoPlayer);
  const Playbar({super.key});
  
  @override
  Widget build(BuildContext context)  {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            // Action for Button 1
            print('Button 2 pressed');
          },
          child: const Icon(Icons.fast_rewind)
        ),

        ElevatedButton(
          onPressed: () {
            // Action for Button 1
            print('Button 1 pressed');
          },
          child: const Icon(Icons.play_arrow)
        ),
          
        ElevatedButton(
          onPressed: () {
            // Action for Button 1
            print('Button 2 pressed');
          },
          child: const Icon(Icons.fast_forward)
        ),
      ],
    );
  }
}