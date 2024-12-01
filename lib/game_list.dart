import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailScreen(match: match),
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

  const MatchDetailScreen({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${match['team1']['teamName']} vs ${match['team2']['teamName']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Match ID: ${match['matchID']}'),
            Text('League: ${match['leagueName']}'),
            Text('Date: ${match['matchDateTime']}'),
            Text('Location: ${match['location']['locationCity']} - ${match['location']['locationStadium']}'),
            const SizedBox(height: 16),
            Text('Team 1: ${match['team1']['teamName']}'),
            Text('Team 2: ${match['team2']['teamName']}'),
            const SizedBox(height: 16),
            if (match['goals'] != null && match['goals'].isNotEmpty)
              ...match['goals'].map<Widget>((goal) => Text(
                  'Minute ${goal['matchMinute']}: ${goal['goalGetterName']} (${goal['scoreTeam1']} - ${goal['scoreTeam2']})')),
          ],
        ),
      ),
    );
  }
}
