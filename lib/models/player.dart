import 'package:flutter_application_1/models/team.dart';

class Player {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String name;
  final String img;
  final Team team;
  final int number;
  final String position;
  final String country;

  Player({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.name,
    required this.img,
    required this.team,
    required this.number,
    required this.position,
    required this.country,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      name: json['name'],
      img: json['img'],
      team: Team.fromJson(json['expand']['team']),
      number: json['number'],
      position: json['position'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'name': name,
      'img': img,
      'team': team.toJson(),
      'number': number,
      'position': position,
      'country': country,
    };
  }
}
