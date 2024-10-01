import 'package:flutter/material.dart';

final List<String> games = <String>['Werder', 'Kiel', 'Bayer', 'Lol'];
final List<int> colorCodes = <int>[600, 500, 100];

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

Widget build(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: games.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.amber[colorCodes[index]],
        child: Center(child: Text('Game ${games[index]}')),
      );
    }
  );
}
}