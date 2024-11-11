import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FileLoaderState extends Equatable {
  const FileLoaderState();

  @override
  List<Object?> get props => [];
}

class NoFile extends FileLoaderState {}

class LoadingFile extends FileLoaderState {
}

class FileLoaded extends FileLoaderState {
  final File file;
  const FileLoaded(this.file);

  @override 
  List<Object?> get props => [this.file];
}