class SportFeed {
  final String id;
  final String? img;
  final String title;
  final String description;
  final String type;
  final String content;
  final DateTime created;
  final DateTime updated;

  SportFeed({
    required this.id,
    required this.img,
    required this.title,
    required this.description,
    required this.type,
    required this.content,
    required this.created,
    required this.updated,
  });

  factory SportFeed.fromJson(Map<String, dynamic> json) {
    return SportFeed(
      id: json['id'],
      img: json['img'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      content: json['content'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'title': title,
      'description': description,
      'type': type,
      'content': content,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }
}
