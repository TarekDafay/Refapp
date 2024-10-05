import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ref_app/bloc/Editor_bloc.dart';
import 'package:ref_app/bloc/videoplayer_bloc.dart';
import 'package:video_player/video_player.dart';

import 'ui/EditorView.dart';
import 'ui/ExportView.dart';
import 'ui/ProjectView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Counter',
            initialRoute: '/project',
      /*
      routes: {
        '/project': (context) => ProjectView(),
        '/editor': (context) => EditorView(),
        '/export': (context) => ExportView(),
      },
      */
      home: MultiBlocProvider(
        providers: [
            BlocProvider( create: (context) => EditorBloc()),          
            BlocProvider( create: (context) => VideoPlayerBloc()),  
        ],
        child: EditorView(),
      ),
    );
  }
}
