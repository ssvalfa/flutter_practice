class League {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String title;
  final String type;
  final String logo;
  final String? team;

  League({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.title,
    required this.type,
    required this.logo,
    this.team,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return League(
        id: '',
        collectionId: '',
        collectionName: '',
        created: DateTime.now(),
        updated: DateTime.now(),
        title: '',
        type: '',
        logo: '',
        team: null,
      );
    }

    return League(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      created: json['created'] != null
          ? DateTime.parse(json['created'])
          : DateTime.now(),
      updated: json['updated'] != null
          ? DateTime.parse(json['updated'])
          : DateTime.now(),
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      logo: json['logo'] ?? '',
      team: json['team'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'title': title,
      'type': type,
      'logo': logo,
      if (team != null) 'team': team,
    };
  }
}
