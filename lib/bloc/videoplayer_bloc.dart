import 'package:bloc/bloc.dart';
import 'videoplayer_event.dart';
import 'videoplayer_state.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBloc extends Bloc<VideoplayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(VideoPlayerState(
    VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))
    )) {
    on<VideoPlayer10SecForwardPressed>((event, emit) {
      //emit(CounterState(state.counterValue + 1));
    });

    on<VideoPlayer10SecBackwardPressed>((event, emit) {
      //emit(CounterState(state.counterValue - 1));
    });
  }
}