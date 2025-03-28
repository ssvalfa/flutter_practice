import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';

class UpcomingMatchesListPage extends StatefulWidget {
  const UpcomingMatchesListPage({super.key});

  @override
  State<UpcomingMatchesListPage> createState() =>
      _UpcomingMatchesListPageState();
}

class _UpcomingMatchesListPageState extends State<UpcomingMatchesListPage> {
  late Future<List<GameMatch>> future;
  @override
  void initState() {
    future = loadData();
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
        child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No matches available.',
                        style: TextStyle(color: Colors.white)));
              } else {
                var matches = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    final match = matches[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: UpcomingCard(
                        leagueLogo1: 'https://placehold.co/40x40.jpg',
                        leagueLogo2: 'https://placehold.co/40x40.jpg',
                        date: match.date,
                        matchTitle:
                            '${match.home.title} VS ${match.guest.title}',
                        matchDate:
                            '${match.date.day}/${match.date.month}/${match.date.year} · ${match.date.hour}:${match.date.minute} · ${match.location.club.title}',
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
