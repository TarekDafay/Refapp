import 'package:flutter/material.dart';
import 'package:ref_app/ApiCalls.dart';

class MatchDetailScreen extends StatelessWidget {
  final int matchId;

  const MatchDetailScreen({required this.matchId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Match Details')),
      body: FutureBuilder<List<Map<String, dynamic>>> (
          future: fetchDetailedMatchData(matchId),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            else if(!snapshot.hasData) {
              return Center(child: Text('No data avaiable.'));
            }
            final matchDetails = snapshot.data!.first;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _resultHeader(context, matchDetails),
                  Row(
                    children: [
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Divider(
                              color: Colors.grey,
                              height: 35,
                              thickness: 2,
                            )
                        ),
                      ),
                    ],
                  ),
                  _DrawGoals(context, matchDetails),
                ],
              )
            );
          }
      )
    );
  }

  Widget _displayImageFromURL(BuildContext context, String ImageURL, int size) {
    return Center(
      child: Image.network(
          ImageURL,
          width: 64,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          }
      ),
    );
  }

  Widget _resultHeader(BuildContext context, Map<String, dynamic> matchDetails) {
    final team1 = matchDetails['team1'];
    final team2 = matchDetails['team2'];
    final int imageSize = 128;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _displayImageFromURL(context, team1['teamIconUrl'],imageSize),
        SizedBox(width: 25,),
        Column(
            children: [Text(
              "${matchDetails['matchResults'][0]['pointsTeam1']} : ${matchDetails['matchResults'][0]['pointsTeam2']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
              Text(
                "${matchDetails['matchResults'][1]['pointsTeam1']} : ${matchDetails['matchResults'][1]['pointsTeam2']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
              ),
            ]
        ),
        SizedBox(width: 25,),
        _displayImageFromURL(context, team2['teamIconUrl'],imageSize),
      ],
    );
  }

  Widget _DrawGoals(BuildContext context, Map<String, dynamic> matchDetails) {
    final sortedGoals = List<Map<String, dynamic>>.from(matchDetails['goals'] ?? []);
    sortedGoals.sort((a, b) => a['matchMinute'].compareTo(b['matchMinute']));
    return Row(
      children: [
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
    );
  }
}

class CustomGameDetailScreen extends StatelessWidget {
  final Map<String,dynamic> match;

  const CustomGameDetailScreen({required this.match, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Match Details')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 35,
                          thickness: 2,
                        )
                    ),
                  ),
                ],
              ),
              _DrawGoals(context),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: ()  {
                      deleteEntry(match['match-id']);
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (Route<
                          dynamic> route) => false);
                  },
                  child: Text("Delete!"),
                ),
              )
            ],
      ),
        )
    );
  }

  Widget _DrawGoals(BuildContext context) {
    final half1 = match['match-events']['first-half']['events'];
    final half2 = match['match-events']['second-half']['events'];

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Goals:', style: TextStyle(fontWeight: FontWeight.bold)),
            _drawHalf(context, half1),
            SizedBox.fromSize(size: Size(30, 40),),
            _drawHalf(context, half2),
          ]
      ),
      ],
    );
  }

  Widget _drawHalf(BuildContext context, var half )  {
    if (half.isNotEmpty)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...half.map((event) => Text(
              'Minute ${event['time']}: ${event['team']} ${event['type']}')),
        ],
      );
    else
      return const Text('Nothing happened in this half');
  }
}