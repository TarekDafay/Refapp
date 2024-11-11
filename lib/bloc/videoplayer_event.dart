import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

abstract class VideoplayerEvent {
  const VideoplayerEvent();

  @override
  List<Object?> get props => [];

}

class VideoPlayerPlayPressed extends VideoplayerEvent {}

class VideoPlayerPausePressed extends VideoplayerEvent {}

class VideoPlayer10SecForwardPressed extends VideoplayerEvent {}

class VideoPlayer10SecBackwardPressed extends VideoplayerEvent {}

class VideoPlayer30SecForwardPressed extends VideoplayerEvent {}

class VideoPlayer30SecBackwardPressed extends VideoplayerEvent {}

class VideoPlayerInitializeController extends VideoplayerEvent {
  final String videoUrl;

  const VideoPlayerInitializeController(this.videoUrl);

  @override
  List<Object> get props => [videoUrl];

}