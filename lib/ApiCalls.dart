import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as html;

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

Future<List<Map<String,dynamic>>> fetchMatchesFromFirebase() async {
  try {
    // Get the current authenticated user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("User not logged in");
    }

    String userId = currentUser.uid;

    // Reference the user's matches in the database
    DatabaseReference matchesRef = FirebaseDatabase.instance
        .ref()
        .child('users/$userId/matches');

    // Fetch data from the database
    DataSnapshot snapshot = await matchesRef.get();
    Map<Object?, Object?>? data = snapshot.value as Map<Object?, Object?>?;

    if (data != null) {
      List<Map<String, dynamic>> listOfMaps = [];

      // Iterate over the map and cast each entry to Map<String, dynamic>
      data.forEach((key, value) {
        if (value is Map) {
          listOfMaps.add(Map<String, dynamic>.from(value as Map<Object?, Object?>));
        }
      });
      return listOfMaps;
    }
  } catch (e) {
    print("Error fetching matches: $e");
  }
  return [];
}


Future<void> deleteEntry(String entryKey) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    throw Exception("User not logged in");
  }

  String userId = currentUser.uid;

  // Reference the user's matches in the database
  DatabaseReference matchesRef = FirebaseDatabase.instance
      .ref()
      .child('users/$userId/matches/$entryKey');

  try {
    await matchesRef.remove();
    print('Entry deleted successfully');
  } catch (e) {
    print('Error deleting entry: $e');
  }
}

