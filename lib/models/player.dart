import 'package:flutter_application_1/models/team.dart';

class Player {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final int number;
  final String position;
  final String img;
  final String country;
  final String team;
  final Team? teamData;
  final DateTime created;
  final DateTime updated;

  Player({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    required this.number,
    required this.position,
    required this.img,
    required this.country,
    required this.team,
    this.teamData,
    required this.created,
    required this.updated,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Player(
        id: '',
        collectionId: '',
        collectionName: '',
        name: '',
        number: 0,
        position: '',
        img: '',
        country: '',
        team: '',
        teamData: null,
        created: DateTime.now(),
        updated: DateTime.now(),
      );
    }

    Team? teamObject;
    if (json['expand'] != null && json['expand']['team'] != null) {
      teamObject = Team.fromJson(json['expand']['team']);
    }

    return Player(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      name: json['name'] ?? '',
      number: json['number'] != null
          ? int.tryParse(json['number'].toString()) ?? 0
          : 0,
      position: json['position'] ?? '',
      img: json['img'] ?? '',
      country: json['country'] ?? '',
      team: json['team'] ?? '',
      teamData: teamObject,
      created: json['created'] != null
          ? DateTime.parse(json['created'])
          : DateTime.now(),
      updated: json['updated'] != null
          ? DateTime.parse(json['updated'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'name': name,
      'number': number,
      'position': position,
      'img': img,
      'country': country,
      'team': team,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };

    return data;
  }
}
