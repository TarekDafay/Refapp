import 'dart:io';

import 'package:bloc/bloc.dart';
import 'FileLoader_state.dart';
import 'FileLoader_event.dart';

class FileLoaderBloc extends Bloc<FileLoaderEvent, FileLoaderState> {
  File? _currentFile;
  FileLoaderBloc() : super(NoFile()) {
    on<LoadFileEvent>(_onLoadFile);
  }

  _onLoadFile(LoadFileEvent event, Emitter<FileLoaderState> emit) {
    emit(LoadingFile());
    _currentFile = File(event.filePath);
    emit(FileLoaded(_currentFile!));
  }
}
