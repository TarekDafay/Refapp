import 'package:bloc/bloc.dart';
import 'videoplayer_event.dart';
import 'videoplayer_state.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBloc extends Bloc<VideoplayerEvent, VideoPlayerState> {
  VideoPlayerController? _controller;

  VideoPlayerBloc() : super(VideoPlayerInitial()) {
    on<VideoPlayerInitializeController>(_onInitializeController);  
    }

  Future<void> _onInitializeController(VideoPlayerInitializeController event, Emitter<VideoPlayerState> emit) async {
    emit(VideoPlayerLoading());

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(event.videoUrl));
      await _controller!.initialize();
      emit(VideoPlayerLoaded(_controller!));
    } catch (e) {
      emit(VideoError('Failed to load video'));
    }
  }
}
  /*
    VideoPlayerState(VideoPlayerController.networkUrl(
        Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))..initialize())
    ) {
    on<VideoPlayer10SecForwardPressed>((event, emit) {
      //emit(CounterState(state.counterValue + 1));
    });

    on<VideoPlayer10SecBackwardPressed>((event, emit) {
      //emit(CounterState(state.counterValue - 1));
    });

    on<VideoPlayerInitializeController>((event, emit) {
      emit(VideoPlayerState((VideoPlayerController.networkUrl(
        Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))..initialize())
    ));
    });
*/