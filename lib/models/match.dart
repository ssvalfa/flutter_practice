import 'package:flutter_application_1/models/stadium.dart';
import 'package:flutter_application_1/models/team.dart';

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
  });

  // Factory method to create Match object from JSON
  factory GameMatch.fromJson(Map<String, dynamic> json) {
    return GameMatch(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: json['created'],
      updated: json['updated'],
      home: Team.fromJson(json['expand']['home']),
      guest: Team.fromJson(json['expand']['guest']),
      date: DateTime.parse(json['date']),
      location: Stadium.fromJson(json['expand']['location']),
      homeScore: json['home_score'],
      guestScore: json['guest_score'],
    );
  }

  // Method to convert Match object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'updated': updated,
      'home': home.toJson(),
      'guest': guest.toJson(),
      'date': date,
      'location': location.toJson(),
      'home_score': homeScore,
      'guest_score': guestScore,
    };
  }
}
