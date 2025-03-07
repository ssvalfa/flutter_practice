import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/widgets/live_card.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';

import '../../models/team.dart';

class TeamsDetailedPage extends StatefulWidget {
  final String id;
  final String title;
  const TeamsDetailedPage({super.key, required this.id, required this.title});

  @override
  State<TeamsDetailedPage> createState() => _TeamsDetailedPageState();
}

class _TeamsDetailedPageState extends State<TeamsDetailedPage> {
  late Future<Team> team;

  Future<Team> getData() async {
    final record =
        await pocketBaseService.pb.collection('sport_teams').getOne(widget.id);
    return Team.fromJson(record.toJson());
  }

  @override
  void initState() {
    super.initState();
    team = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.title),
        ),
      ),

      body: SafeArea(
          child: FutureBuilder(
              future: team,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No teams available.'));
                } else {
                  final Team team = snapshot.data!;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        LiveCard(),
                        Text(team.title),
                        Text(team.country),
                        Text(team.type),
                        Text(team.collectionId),
                        Text(team.created),
                      ],
                    ),
                  );
                }
              })),
      // body: ListView(
      //   padding: const EdgeInsets.all(16),
      //   children: [
      //     const LiveCard(),
      //     const SizedBox(height: 20),
      //     // UpcomingCard(
      //     //   leagueLogo1: 'https://placehold.co/8x8.png',
      //     //   leagueLogo2: 'https://placehold.co/8x8.png',
      //     //   matchTitle: "M United VS Barcelona",
      //     //   matchDate: "Tuesday, 9 Mar 2021, 05:00 AM",
      //     // ),
      //     // const SizedBox(height: 10),
      //     // UpcomingCard(
      //     //   leagueLogo1: 'https://placehold.co/8x8.png',
      //     //   leagueLogo2: 'https://placehold.co/8x8.png',
      //     //   matchTitle: "M United VS Barcelona",
      //     //   matchDate: "Tuesday, 9 Mar 2021, 05:00 AM",
      //     // ),
      //   ],
      // ),
    );
  }
}
