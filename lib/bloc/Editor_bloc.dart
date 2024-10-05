import 'package:bloc/bloc.dart';
import 'Editor_event.dart';
import 'Editor_state.dart';
import 'package:video_player/video_player.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(EditorState()) {}
}