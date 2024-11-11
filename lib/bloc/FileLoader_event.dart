import 'package:equatable/equatable.dart';

abstract class FileLoaderEvent {
  const FileLoaderEvent();

  @override
  List<Object?> get props => [];

}

class LoadFileEvent extends FileLoaderEvent {
  final String filePath;
  const LoadFileEvent(this.filePath);
}