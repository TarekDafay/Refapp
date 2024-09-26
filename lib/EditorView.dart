import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Videoplayer.dart';
import 'Playbar.dart';
import 'Toolbar.dart';

class EditorView extends StatelessWidget {
  final VideoPlayerController controller;
  EditorView ({super.key}) : controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

  Scaffold portraitView(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: Toolbar(),
        body: Column(
          children: <Widget> [
            Row(
              children: [VideoPlayerScreen(controller: controller)
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Playbar(controller: controller,)],
            ),
            Container (child: Text("$width"),
            ),
            Container (child: Text("$height"),
            ),
            Container (child: TestClass(),
            ),
          ]
        )
    );
  }

  Scaffold landscapeView(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(),
        body: const Row(
            children: [
            Expanded(
              child: Column(
                children: [
                  RotatedBox(
                  quarterTurns: 0,
                  child: VideoPlayerScreen(controller: controller,)
              ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Playbar(controller: controller)],
              ),
            ),
            ],
        )
      );
  }

  @override
  Widget build(BuildContext context)  {
    if(MediaQuery.orientationOf(context)== Orientation.portrait) {
      return portraitView(context);
    } else  {
      return landscapeView(context);
    }
      
  }
}

class TestClass extends StatefulWidget {
  const TestClass({super.key});

  @override
  State<TestClass> createState() => TestClassState();
}

class TestClassState extends State<TestClass> {
  
  @override
  void initState()  {
    super.initState();
  }
  void playVideo() {
    print("Hello im under de Water, please help me, its too much raining, wuuuh");
  }

  @override
  Widget build(BuildContext context) {return const Scaffold();}
}