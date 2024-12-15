import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as html;

class FussballDeParser {
    final String _url;
    final String _role;

    FussballDeParser(this._url, this._role) {
      _writeMatchInfoToDataBase();
    }

    dynamic _getTeam(String identifier, var document) async {
      var teams = document.getElementsByClassName(identifier);
      var teamName;
      var fullHomeImgUrl;
      for (var team in teams) {
        var teamNameElement = team.querySelector('.team-name a');
        teamName = teamNameElement?.text.trim() ?? 'Unknown';

        var imgElement = team.querySelector('.team-logo img');
        var imgSrc = imgElement?.attributes['src'] ?? 'No image link';

        fullHomeImgUrl = imgSrc.startsWith('http')
            ? imgSrc
            : 'https://www.fussball.de$imgSrc';
      }

      Map<String, dynamic> result = {
        'name' : teamName,
        'img' : fullHomeImgUrl,
      };
      return result;
    }

    Future<Map<String,dynamic>> _getTeams(var document) async  {
      final homeTeam = await _getTeam('team-home', document);
      final awayTeam = await _getTeam('team-away', document);

      Map<String, dynamic> result = {
        'home-team': homeTeam,
        'away-team': awayTeam
      };

      return result;
    }

    Future<Map<String,dynamic>> _getMatchEvents(var document) async  {
      final element = document.querySelector('#rangescontainer');
      if(element != null) {
        final dataMatchEvents = element.attributes['data-match-events'];
        if(dataMatchEvents != null) {
          final matchEvents = json.decode(dataMatchEvents.replaceAll("'", '"')) as Map<String,dynamic>;
          return matchEvents;
        }
      }
      return Map<String,dynamic>();
    }

    Future<Map<String,dynamic>> _getMatchFacts(var document) async {
      var ogTitleElement = document.querySelector('meta[property="og:title"]');
      var ogTitle = ogTitleElement?.attributes['content'] ?? '';

      RegExp dateRegExp = RegExp(r'(\d{2}\.\d{2}\.\d{4})');
      var match = dateRegExp.firstMatch(ogTitle);
      var date = 'Unknown';
      if (match != null) {
        date = match.group(0)!; // The matched date (e.g., "14.12.2024")
        print('Date: $date');
      } else {
        print('No date found.');
      }

      // Find the <span> tag inside the "headline" div
      var headlineElement = document.querySelector('.headline span');

      // Extract the time (kickoff time) from the <span> tag
      var kickoffTime = headlineElement?.text.trim() ?? 'No kickoff time found';

      kickoffTime = kickoffTime.replaceAll(RegExp(r'Uhr$'), '');

      var compName = 'Unknown';
      var element = document.querySelector('#stage > div > div > div > div > div.stage-header > a.competition');
      var competitionName = element?.text.trim() ?? 'Not found';


      print('Kickoff Time: $kickoffTime');
      Map<String, dynamic> result = {
        'date': date,
        'kickoff-time': kickoffTime,
        'competition' : competitionName,
      };

      return result;

    }

    Future<void> _writeMatchInfoToDataBase()  async {
      DatabaseReference database = FirebaseDatabase.instance.ref();
      final response = await http.get(Uri.parse(_url));
      final document = html.parse(response.body);

      final Map<String,dynamic> matchEvents = await _getMatchEvents(document);
      final Map<String,dynamic> teams = await _getTeams(document);
      final Map<String,dynamic> matchFacts = await _getMatchFacts(document);

      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? currentUser = _auth.currentUser;

      if(currentUser == null) {
        return;
      }
      String userId = currentUser.uid;
      String dbPath = 'users/$userId/matches';
      String matchId = database.child(dbPath).push().key!;

      Map<String,dynamic> dbEntry = {
          'match-facts' : matchFacts,
          'role' : _role,
          'teams' : teams,
          'match-events' : matchEvents,
          'match-url' : _url,
      };

      dbPath += "/$matchId";
      await database.child(dbPath).set(dbEntry);
    }
}

class MatchEvent {
  final String time;
  final String eventDescription;
  final String team;

  MatchEvent(this.time, this.eventDescription, this.team);

  @override
  String toString() {
    return '[$time] $eventDescription by $team';
  }

  Map<String,dynamic> toJson() {
    return {
      'time': time,
      'event' : eventDescription,
      'team' : team,
    };
  }
}