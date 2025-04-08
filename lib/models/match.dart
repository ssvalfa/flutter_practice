import 'package:flutter_application_1/models/stadium.dart';
import 'package:flutter_application_1/models/team.dart';
import 'package:flutter_application_1/models/league.dart'; // Импортируем League

class GameMatch {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final Team home;
  final Team guest;
  final DateTime date;
  final Stadium location;
  final int homeScore;
  final int guestScore;
  final String type;
  final League? league;

  GameMatch({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.home,
    required this.guest,
    required this.date,
    required this.location,
    required this.homeScore,
    required this.guestScore,
    required this.type,
    this.league,
  });

  factory GameMatch.fromJson(Map<String, dynamic> json) {
    return GameMatch(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      home: Team.fromJson(json['expand']['home']),
      guest: Team.fromJson(json['expand']['guest']),
      date: DateTime.parse(json['date']),
      location: Stadium.fromJson(json['expand']['location']),
      homeScore: json['home_score'],
      guestScore: json['guest_score'],
      type: json['type'],
      league: json['expand']?['league'] != null
          ? League.fromJson(json['expand']['league'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'home': home.toJson(),
      'guest': guest.toJson(),
      'date': date.toIso8601String(),
      'location': location.toJson(),
      'home_score': homeScore,
      'guest_score': guestScore,
      'type': type,
      'league': league?.toJson(),
    };
  }
}
