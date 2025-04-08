import 'league.dart';

class Team {
  final String collectionId;
  final String collectionName;
  final String country;
  final String created;
  final String id;
  final String img;
  final String title;
  final String updated;
  final String type;
  final League? league; // добавлено

  Team({
    required this.collectionId,
    required this.collectionName,
    required this.country,
    required this.created,
    required this.id,
    required this.img,
    required this.title,
    required this.updated,
    required this.type,
    this.league,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      country: json['country'],
      created: json['created'],
      id: json['id'],
      img: json['img'],
      title: json['title'],
      updated: json['updated'],
      type: json['type'],
      league: json['expand']?['leagues'] != null
          ? League.fromJson(json['expand']['leagues'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'collectionId': collectionId,
        'collectionName': collectionName,
        'country': country,
        'created': created,
        'id': id,
        'img': img,
        'title': title,
        'updated': updated,
        'type': type,
        'leagues': league?.toJson(),
      };
}
