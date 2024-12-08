import 'package:flutter/material.dart';


class MatchDetailScreen extends StatelessWidget {
  final Map<String, dynamic> match;

  final String formattedDate;

  const MatchDetailScreen({Key? key, required this.match, required this.formattedDate}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final sortedGoals = List<Map<String, dynamic>>.from(match['goals'] ?? []);
    sortedGoals.sort((a, b) => a['matchMinute'].compareTo(b['matchMinute']));
    return Scaffold(
      appBar: AppBar(
        title: Text('${match['team1']['shortName']} vs ${match['team2']['shortName']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${match['group']['groupName']}'),
            Text('Liga: ${match['leagueName']}'),
            Text('Datum: $formattedDate'),
            Text('Wo: ${match['location']['locationCity']} - ${match['location']['locationStadium']}'),
            const SizedBox(height: 16),
            Text('Team 1: ${match['team1']['teamName']}'),
            Text('Team 2: ${match['team2']['teamName']}'),
            const SizedBox(height: 16),
            if (sortedGoals.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Goals:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...sortedGoals.map((goal) => Text(
                      'Minute ${goal['matchMinute']}: ${goal['goalGetterName']} (${goal['scoreTeam1']} - ${goal['scoreTeam2']})')),
                ],
              )
            else
              const Text('No goals in this match'),
          ],
        ),
      ),
    );
  }
}
