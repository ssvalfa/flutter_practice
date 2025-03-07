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

  Team(
      {required this.collectionId,
      required this.collectionName,
      required this.country,
      required this.created,
      required this.id,
      required this.img,
      required this.title,
      required this.updated,
      required this.type});

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
        type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'country': country,
      'created': created,
      'id': id,
      'img': img,
      'title': title,
      'updated': updated,
      'type': type
    };
  }
}
