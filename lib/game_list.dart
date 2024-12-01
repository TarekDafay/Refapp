import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


// Api documentation available at https://api.openligadb.de/index.html
// const endpoint = "https://api.openligadb.de/getmatchdata/"; // https://api.openligadb.de/getmatchdata/bl1/2020/1
const endpoint = "https://api.openligadb.de/getmatchdata/bl1/2020/1";



class MatchesListView extends StatefulWidget {
  @override
  _MatchesListViewState createState() => _MatchesListViewState();
}

class _MatchesListViewState extends State<MatchesListView> {
  late Future<List<Map<String, dynamic>>> matches;

  Future<List<Map<String, dynamic>>> fetchMatches() async {
    final url = Uri.parse(endpoint); // Replace with your API endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map<Map<String, dynamic>>((match) => match).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }

  String formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd.MM.yyyy').format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    matches = fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: matches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No matches found'));
          }

          final matchesData = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: matchesData.length,
            itemBuilder: (context, index) {
              final match = matchesData[index];
              final String formattedDate = formatDate(match['matchDateTime']);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailScreen(match: match, formattedDate: formattedDate),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Center(
                    child: Text('${match['team1']['teamName']} vs ${match['team2']['teamName']}'),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        },
      ),
    );
  }
}

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
            Text("Goals:", style: const TextStyle(fontWeight: FontWeight.bold)),
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
