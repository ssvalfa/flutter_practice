import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';

class UpcomingMatchesListPage extends StatefulWidget {
  final String? sportType;
  const UpcomingMatchesListPage({super.key, this.sportType});

  @override
  State<UpcomingMatchesListPage> createState() =>
      _UpcomingMatchesListPageState();
}

class _UpcomingMatchesListPageState extends State<UpcomingMatchesListPage> {
  late Future<List<GameMatch>> _futureMatches;
  @override
  void initState() {
    _futureMatches = loadData();
    super.initState();
  }

  Future<List<GameMatch>> loadData() async {
    final request = pocketBaseService.pb.collection("sport_match");
    print(widget.sportType);
    final record = await (widget.sportType == null || widget.sportType == "null"
        ? request.getFullList(expand: 'location.club, home, guest')
        : request.getFullList(
            expand: 'location.club, home, guest',
            filter: 'type="${widget.sportType}"'));

    return record.map((el) => GameMatch.fromJson(el.toJson())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Upcoming Matches'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<GameMatch>>(
          future: _futureMatches,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error loading matches: ${snapshot.error}',
                  style: TextStyle(color: Colors.white));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No upcoming matches.',
                  style: TextStyle(color: Colors.white));
            } else {
              final matches = snapshot.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: matches
                      .take(100)
                      .map((match) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: UpcomingCard(match: match),
                          ))
                      .toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
