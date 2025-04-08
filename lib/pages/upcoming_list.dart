import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';

import '../utils/constants.dart';

class UpcomingMatchesListPage extends StatefulWidget {
  const UpcomingMatchesListPage({super.key});

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
    final record = await pocketBaseService.pb
        .collection("sport_match")
        .getFullList(expand: 'location.club, home, guest');
    print(record);
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
              return Column(
                children: matches
                    .take(100)
                    .map((match) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: UpcomingCard(match: match),
                        ))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
