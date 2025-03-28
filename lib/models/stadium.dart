import 'team.dart';

class Stadium {
  final String id;
  final String collectionId;
  final String collectionName;
  final String title;
  final String city;
  final Team club;

  Stadium(
      {required this.id,
      required this.collectionId,
      required this.collectionName,
      required this.title,
      required this.city,
      required this.club});
  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      title: json['title'],
      city: json['city'],
      club: Team.fromJson(
          json['expand']['club']), // Assuming Team has a fromJson method
    );
  }

  // Method to convert Stadium object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'city': city,
      'club': club.toJson(), // Assuming Team has a toJson method
    };
  }
}
