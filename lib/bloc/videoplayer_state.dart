import 'package:video_player/video_player.dart';

class VideoPlayerState {
  final VideoPlayerController controller;

  VideoPlayerState(this.controller){controller.initialize();}

  @override
  VideoPlayerController get playerController => controller;//[counterValue];
}
