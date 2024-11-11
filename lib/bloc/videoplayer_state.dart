import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object?> get props => [];
}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerLoaded extends VideoPlayerState{
  final VideoPlayerController controller;

  const VideoPlayerLoaded(this.controller);

  @override 
  List<Object?> get props => [this.controller];
}

class VideoError extends VideoPlayerState {
  final String message;
  const VideoError(this.message);

  List<Object?> get props => [this.message];
}
