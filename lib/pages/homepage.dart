import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/feed.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/widgets/live_card.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/widgets/feed_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late Future<List<SportFeed>> _futureFeed;
  late Future<List<GameMatch>> _futureMatches;
  int? _selectedLeagueIndex;
  String? _selectedFilter;

  final List<Map<String, dynamic>> leagues = [
    {"label": "All", "icon": Icons.sports, "filter": null},
    {"label": "Football", "icon": Icons.sports_soccer, "filter": "football"},
    {
      "label": "Basketball",
      "icon": Icons.sports_basketball,
      "filter": "basketball"
    },
    {"label": "Kokboru", "icon": Icons.sports_volleyball, "filter": "kokboru"},
    {
      "label": "Cybersport",
      "icon": Icons.sports_esports,
      "filter": "cybersport"
    },
  ];

  @override
  void initState() {
    super.initState();
    _futureFeed = fetchNews();
    _futureMatches = fetchMatches();
  }

  void selectLeague(int? index) {
    setState(() {
      _selectedLeagueIndex = index;
      _selectedFilter = index != null ? leagues[index]["filter"] : null;
      _futureFeed = fetchNews(_selectedFilter);
      _futureMatches = fetchMatches(_selectedFilter);
    });
  }

  Future<List<GameMatch>> fetchMatches([String? filter]) async {
    final record =
        await pocketBaseService.pb.collection("sport_match").getFullList(
              expand: 'location.club, home, guest',
              filter: filter != null ? 'type="$filter"' : null,
            );
    return record.map((el) => GameMatch.fromJson(el.toJson())).toList();
  }

  Future<List<SportFeed>> fetchNews([String? filter]) async {
    final records =
        await pocketBaseService.pb.collection('sport_feed').getFullList(
              sort: '-created',
              filter: filter != null ? 'type="$filter"' : null,
            );
    return records
        .map((record) => SportFeed.fromJson(record.toJson()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureFeed,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: \${snapshot.error}'));
            } else {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF212121), Color(0xFF1A1A1A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi Vincent,',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Let's keep a note of all the kicks.",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.search,
                                      color: Colors.white, size: 24),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    onPressed: () {
                                      context.push('/teams');
                                    },
                                    icon: const Icon(Icons.grid_view_rounded,
                                        color: Colors.white, size: 24),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(leagues.length, (index) {
                                final league = leagues[index];
                                final isSelected =
                                    _selectedLeagueIndex == index;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: FilledButton.icon(
                                    onPressed: () => selectLeague(index),
                                    style: FilledButton.styleFrom(
                                        backgroundColor: isSelected
                                            ? Color.fromARGB(255, 123, 184, 25)
                                            : Colors.grey[800],
                                        minimumSize: Size(50, 50)),
                                    icon: Icon(league["icon"],
                                        color: Colors.white),
                                    label: Text(league["label"],
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text('Matches',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Container(
                              width: 50, height: 3, color: Color(0xFFB6FF40)),
                          const SizedBox(height: 16),
                          const Text('Live matches',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const LiveCard(),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('UPCOMING MATCHES',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  context.push('/upcominglist');
                                },
                                child: const Text('VIEW ALL',
                                    style: TextStyle(
                                        color: Color(0xFFB6FF40),
                                        fontSize: 14)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                              width: 50, height: 3, color: Color(0xFFB6FF40)),
                          const SizedBox(height: 16),
                          FutureBuilder<List<GameMatch>>(
                            future: _futureMatches,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Error loading matches: ${snapshot.error}',
                                    style: TextStyle(color: Colors.white));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text('No upcoming matches.',
                                    style: TextStyle(color: Colors.white));
                              } else {
                                final matches = snapshot.data!;
                                return Column(
                                  children: matches
                                      .take(2)
                                      .map((match) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: UpcomingCard(match: match),
                                          ))
                                      .toList(),
                                );
                              }
                            },
                          ),
                          const Text('Feed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Container(
                              width: 50, height: 3, color: Color(0xFFB6FF40)),
                          const SizedBox(height: 16),
                          FutureBuilder<List<SportFeed>>(
                            future: _futureFeed,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: \${snapshot.error}',
                                    style: TextStyle(color: Colors.white));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text('No feed found.',
                                    style: TextStyle(color: Colors.white));
                              }
                              final feeds = snapshot.data!;
                              return Column(
                                children: feeds
                                    .take(2)
                                    .map((feed) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: FeedCard(feed: feed),
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
