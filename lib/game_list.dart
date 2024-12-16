import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ref_app/MatchDetailsScreen.dart';
import 'package:ref_app/ApiCalls.dart';
import 'package:ref_app/AddGamePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MatchesListView extends StatefulWidget {
  @override
  _MatchesListViewState createState() => _MatchesListViewState();
}

class _MatchesListViewState extends State<MatchesListView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sections = [
      {
        'title': 'Bundesliga',
        'seasons': [
          {'year': '2022', 'startMatchday': 1, 'endMatchday': 34}, // Matchdays 1 to 10
          {'year': '2023', 'startMatchday': 1, 'endMatchday': 34},  // Matchdays 1 to 6
          {'year': '2024', 'startMatchday': 1, 'endMatchday': 34}, // Matchdays 5 to 12
        ],
      },
      {
        'title': 'Your Matches',
        'userId': 'user123',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
      ),
      body:
        ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            final title = section['title'] ?? 'Unkown';

            if(title == 'Bundesliga') {
              final seasons = section['seasons'] ?? [];
              return SectionWidget (
                title: title,
                seasons: seasons,
              );
            } else if(title == 'Your Matches') {
              return UserMatchesSection();
            }
          }
        ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> seasons;

  const SectionWidget({required this.title, required this.seasons, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      children: seasons
          .map((season) => SeasonWidget(
        year: season['year'],
        startMatchday: season['startMatchday'],
        endMatchday: season['endMatchday'],
      ))
          .toList(),
    );
  }
}

class UserMatchesSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => _userMatchesState();
}

class _userMatchesState extends State<UserMatchesSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text('Your Matches'),
        children: [
        FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchMatchesFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading matches'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No matches available'));
          }

          List<Map<String,dynamic>> matches = snapshot.data!;
          int i = 0;
          print(matches);
          return Column(
            children:
              matches.map((match) {
                final String homeTeam = match['teams']['home-team']['name'];
                final String awayTeam = match['teams']['away-team']['name'];

                return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomGameDetailScreen(match: match)
                    ),
                  );
                },
                child: ListTile(
                  title: Text("$homeTeam vs $awayTeam" ?? 'Unknown Match'),
                ),
              );
            }).toList(),

          );
        }
        ),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => createFussballDEGamePage()
                ),
              );
            },
            child: Text("Create New!"),
          ),
        )
      ],
    );
  }
}


class SeasonWidget extends StatelessWidget {
  final String year;
  final int startMatchday;
  final int endMatchday;

  const SeasonWidget({
    required this.year,
    required this.startMatchday,
    required this.endMatchday,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matchdays = List.generate(endMatchday - startMatchday + 1, (index) => startMatchday + index);

    return ExpansionTile(
      title: Text('Season $year'),
      children: matchdays
          .map((matchday) => MatchdayWidget(
        year: year,
        matchday: matchday,
      ))
          .toList(),
    );
  }
}

class MatchdayWidget extends StatelessWidget {
  final String year;
  final int matchday;

  const MatchdayWidget({required this.year, required this.matchday, Key? key}) : super(key: key);


  String formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd.MM.yyyy').format(parsedDate);
  }


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Matchday $matchday'),
      children: [
        FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchEssentialMatchData(year, matchday),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading matches'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No matches available'));
            }

            final matches = snapshot.data!;
            return Column(
              children: matches.map((match) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchDetailScreen(
                          matchId: match['id'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(match['name'] ?? 'Unknown Match'),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
