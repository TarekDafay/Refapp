import 'package:flutter/material.dart';
import 'package:ref_app/ApiCalls.dart';

class Statistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
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
        Map<String,int> refYellows = _fetchAccumulated("yellow-card", "Referee", matches);
        Map<String,int> refReds = _fetchAccumulated("red-card", "Referee", matches);
        Map<String,int> refGoals = _fetchAccumulated("goal", "Referee", matches);

        Map<String,int> assistantYellows = _fetchAccumulated("yellow-card", "Assistant", matches);
        Map<String,int> assistantReds = _fetchAccumulated("red-card", "Assistant", matches);
        Map<String,int> assistantGoals = _fetchAccumulated("goal", "Assistant", matches);

        Map<String,int> spectatorYellows = _fetchAccumulated("yellow-card", "Spectator", matches);
        Map<String,int> spectatorReds = _fetchAccumulated("red-card", "Spectator", matches);
        Map<String,int> spectatorGoals = _fetchAccumulated("goal", "Spectator", matches);
        
        return Padding(padding:
          const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25,),
              Text("Role: Referee"),
              Text("${refGoals["matches"]} Matches"),
              _createTable(refYellows, refReds, refGoals),
              SizedBox(height: 25,),
              Text("Role: Assistant"),
              Text("${assistantGoals["matches"]} Matches"),
              _createTable(assistantYellows, assistantReds, assistantGoals),
              SizedBox(height: 25,),
              Text("Role: Spectator"),
              Text("${spectatorGoals["matches"]} Matches"),
              _createTable(spectatorYellows, spectatorReds, spectatorGoals),
            ],
          )
          );
        }
      ),
    );
  }

  Map<String, int> _fetchAccumulated(String key, String role, List<Map<String,dynamic>> matches)  {
    int home = 0;
    int away = 0;
    int acc = 0;
    int matchAmount = 0;

      for (var match in matches) {
        try {
          final half1 = match['match-events']['first-half']['events'];
          final half2 = match['match-events']['first-half']['events'];
          final all = half1 + half2;
          if (match["role"] == role) {
            for (var event in all) {
              if (event["type"] == key) {
                if (event["team"] == "home") {
                  home++;
                } else {
                  away++;
                }
                acc++;
              }
            }
            matchAmount++;
          }
        } catch(e)  {
          print("The match has not happened yet");
      }
    }
    return {
      "home" : home,
      "away" : away,
      "acc" : acc,
      "matches" : matchAmount,
    };
  }


  Widget _createTable(Map<String,int> yellows, Map<String,int> reds, Map<String,int> goals) {
    return Table(
      border: TableBorder.all(), // Adds borders to the table
      columnWidths: const {
        0: FlexColumnWidth(2), // Adjust the width of columns as needed
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(children: [
          Container(), // Empty cell
          Center(child: Text('Home', style: TextStyle(fontWeight: FontWeight.bold))),
          Center(child: Text('Away', style: TextStyle(fontWeight: FontWeight.bold))),
          Center(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
        ]),
        TableRow(children: [
          Center(child: Text('Yellow Cards')),
          Center(child: Text(yellows["home"].toString())),
          Center(child: Text(yellows["away"].toString())),
          Center(child: Text(yellows["acc"].toString())),
        ]),
        TableRow(children: [
          Center(child: Text('Red Cards')),
          Center(child: Text(reds["home"].toString())),
          Center(child: Text(reds["away"].toString())),
          Center(child: Text(reds["acc"].toString())),
        ]),
        TableRow(children: [
          Center(child: Text('Goals')),
          Center(child: Text(goals["home"].toString())),
          Center(child: Text(goals["away"].toString())),
          Center(child: Text(goals["acc"].toString())),
        ]),
      ],
    );
  }

}
