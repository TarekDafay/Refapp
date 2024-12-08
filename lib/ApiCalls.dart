import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

// Api documentation available at https://api.openligadb.de/index.html
// const endpoint = "https://api.openligadb.de/getmatchdata/"; // https://api.openligadb.de/getmatchdata/bl1/2020/1
//const endpoint = "https://api.openligadb.de/getmatchdata/bl1/2020/1";

Future<List<Map<String, dynamic>>> fetchEssentialMatchData(String year, int matchday) async {
  final url = 'https://api.openligadb.de/getmatchdata/bl1/$year/$matchday'; // Updated API URL
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parse the response JSON
      List<dynamic> data = json.decode(response.body);

      // Map the JSON data to a List of Matches
      return data.map((match) {
        final team1Name = match['team1']?['shortName'] ?? 'Unknown Team 1';
        final team2Name = match['team2']?['shortName'] ?? 'Unknown Team 2';
        final matchId = match['matchID'];
        return {
          'id': matchId,
          'name': '$team1Name vs $team2Name',
        };
      }).toList();
    } else {
      // Handle errors (non-200 status codes)
      throw Exception('Failed to load matches');
    }
  } catch (e) {
    // Handle any errors during the HTTP request
    print('Error fetching matches: $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchDetailedMatchData(int matchId) async {
  final url = 'https://api.openligadb.de/getmatchdata/$matchId'; // Updated API URL
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map) {
        return [data as Map<String, dynamic>];
      } else  {
        throw Exception("Unexpected Data format");
      }

    } else {
      // Handle errors (non-200 status codes)
      throw Exception('Failed to load matches');
    }
  } catch (e) {
    // Handle any errors during the HTTP request
    print('Error fetching matches: $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchUserMatches(String userId) async {
  // TODO Create correct implementation
  return [];
}


