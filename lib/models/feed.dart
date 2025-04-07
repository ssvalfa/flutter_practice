class SportFeed {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String img;
  final String title;
  final String description;
  final String type;
  final String content;

  SportFeed({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.img,
    required this.title,
    required this.description,
    required this.type,
    required this.content,
  });

  factory SportFeed.fromJson(Map<String, dynamic> json) {
    return SportFeed(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      img: json['img'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'img': img,
      'title': title,
      'description': description,
      'type': type,
      'content': content,
    };
  }
}
