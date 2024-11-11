import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ref_app/bloc/videoplayer_bloc.dart';
import 'package:ref_app/bloc/videoplayer_state.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoplayerWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double videoWidth = MediaQuery.orientationOf(context)== Orientation.portrait ? MediaQuery.sizeOf(context).width : MediaQuery.sizeOf(context).height; 
    //Future<void> initializeVideoPlayerFuture = BlocProvider.of<VideoPlayerBloc>(context).state.controller.initialize();

    late VideoPlayerController controller; 
    var state = BlocProvider.of<VideoPlayerBloc>(context).state;
    if(state is VideoPlayerLoaded)  {
      controller = (state as VideoPlayerLoaded).controller;
    } else  {
      return Scaffold(body: Center(child: Text(state.toString())));    
    }
    return 
    Scaffold(
      body: BlocBuilder<VideoPlayerBloc,VideoPlayerState>(
        builder: (context,state)  {
              if(controller.value.isInitialized)  {
                  return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                    );
              }
              // If Videoplayer is still initializing
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
        },
        
    ));
  }
}