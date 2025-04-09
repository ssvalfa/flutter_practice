import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/models/player.dart';
import 'package:flutter_application_1/models/team.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';

class TeamsDetailedPage extends StatefulWidget {
  final String id;
  final String title;

  const TeamsDetailedPage({super.key, required this.id, required this.title});

  @override
  State<TeamsDetailedPage> createState() => _TeamsDetailedPageState();
}

class _TeamsDetailedPageState extends State<TeamsDetailedPage> {
  late Future<Team> team;
  late Future<List<GameMatch>> matches;
  late Future<List<Player>> players;

  Future<Team> getTeamData() async {
    final record = await pocketBaseService.pb
        .collection('sport_teams')
        .getOne(widget.id, expand: 'leagues');

    return Team.fromJson(record.toJson());
  }

  Future<List<GameMatch>> getMatches() async {
    final result =
        await pocketBaseService.pb.collection('sport_match').getFullList(
              expand: 'home,guest,location,league',
              filter:
                  'home="${widget.id}" || guest="${widget.id}" && date >= "${DateTime.now().toUtc().toIso8601String()}"',
              sort: 'date',
            );
    return result.map((e) => GameMatch.fromJson(e.toJson())).toList();
  }

  Future<List<Player>> getPlayers() async {
    final result =
        await pocketBaseService.pb.collection('sport_players').getFullList(
              filter: 'team="${widget.id}"',
              expand: 'team',
            );
    return result.map((e) => Player.fromJson(e.toJson())).toList();
  }

  @override
  void initState() {
    super.initState();
    team = getTeamData();
    matches = getMatches();
    players = getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Общие сведения
              _buildTeamInfo(team),

              const SizedBox(height: 20),

              // Приближающиеся матчи
              Text("Upcoming Matches",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 10),
              _buildMatches(matches),
              const SizedBox(height: 20),

              // Игроки
              Text("Players",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 10),
              _buildPlayerCard(players)
            ],
          ),
        ));
  }

  Widget _buildTeamInfo(Future<Team> teamFuture) {
    return FutureBuilder<Team>(
        future: teamFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No team data found'));
          }

          final team = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    '${AppConstants.url}/api/files/${team.collectionId}/${team.id}/${team.img}',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey,
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(team.title,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(team.country,
                          style: const TextStyle(color: Colors.white70)),
                      Text(team.type,
                          style: const TextStyle(color: Colors.white70)),
                      Text(team.league?.title ?? '',
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _buildMatches(Future<List<GameMatch>> matches) {
    return FutureBuilder<List<GameMatch>>(
      future: matches,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final matches = snapshot.data!;
        return matches.isNotEmpty
            ? Column(
                children:
                    matches.map((match) => UpcomingCard(match: match)).toList(),
              )
            : const Center(child: Text("No matches found"));
      },
    );
  }

  Widget _buildPlayerCard(Future<List<Player>> playerFuture) {
    return FutureBuilder<List<Player>>(
      future: playerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final players = snapshot.data!;
        return Column(
          children: players
              .map((player) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            '${AppConstants.url}/api/files/${player.collectionId}/${player.id}/${player.img}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(player.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text("Number: ${player.number}",
                                style: const TextStyle(color: Colors.white70)),
                            Text("Position: ${player.position}",
                                style: const TextStyle(color: Colors.white70)),
                          ],
                        )
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
