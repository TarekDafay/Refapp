import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Team {
  final int teamId;
  final String teamName;

  const Team({
    required this.teamId,
    required this.teamName,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "teamId": int teamId,
        "teamName": String teamName,
      } =>
        Team(
          teamId: teamId,
          teamName: teamName,
        ),
      _ => throw const FormatException("failed to load team."),
    };
  }
}

class Game {
  final Team team1;
  final Team team2;

  const Game({
    required this.team1,
    required this.team2,
  });

  // factory Game.formJson(Map<String, dynamic> json) {}
}

class GameList extends StatelessWidget {
  final List<String> entries = <String>["A", "B", "C", "Uwu"];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[100],
            child: Center(child: Text("entry ${entries[index]}")),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
  }
}
