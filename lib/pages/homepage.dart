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
  @override
  @override
  void initState() {
    super.initState();
    _futureFeed = fetchNews();
    _futureMatches = fetchMatches();
  }

  Future<List<GameMatch>> fetchMatches() async {
    final record = await pocketBaseService.pb
        .collection("sport_match")
        .getFullList(expand: 'location.club, home, guest');
    return record.map((el) => GameMatch.fromJson(el.toJson())).toList();
  }

  Future<List<SportFeed>> fetchNews() async {
    try {
      final records =
          await pocketBaseService.pb.collection('sport_feed').getFullList(
                sort: '-created',
              );

      List<SportFeed> news =
          records.map((record) => SportFeed.fromJson(record.toJson())).toList();
      return news;
    } catch (e) {
      throw Exception('Failed to fetch quiz details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF212121), // Тёмный фон
      body: SafeArea(
          child: FutureBuilder(
              future: _futureFeed,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No news available.'));
                } else {
                  return Stack(children: [
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
                            // Верхняя панель (приветствие и иконки)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Приветствие
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
                                // Иконки поиска и переключателя вида
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      onPressed: () {
                                        context.push('/teams');
                                      },
                                      icon: const Icon(
                                        Icons.grid_view_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            // Заголовок Matches
                            const Text(
                              'Matches',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Линия или кастомная вкладка
                            Container(
                              width: 50,
                              height: 3,
                              color: const Color(
                                  0xFFB6FF40), // Пример светло-зелёного
                            ),
                            const SizedBox(height: 16),

                            // Горизонтальный список лиг (с иконками)
                            // SizedBox(
                            //   height: 60,
                            //   child: ListView(
                            //     scrollDirection: Axis.horizontal,
                            //     children: [
                            //       ...leagues.map((e) {
                            //         int index = leagues.indexOf(e);
                            //         return LeagueItem(
                            //           label: e["label"],
                            //           iconData: e['icon'],
                            //           isSelected: _leagueIndex == index,
                            //           onTap: () => selectLeague(index),
                            //         );
                            //       })
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(height: 16),

                            // -----------------------------
                            const Text(
                              'Live matches',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const LiveCard(),
                            // -----------------------------

                            const SizedBox(height: 16),

                            // Upcoming Matches
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'UPCOMING MATCHES',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push('/upcominglist');
                                  },
                                  child: const Text(
                                    'VIEW ALL',
                                    style: TextStyle(
                                      color: Color(0xFFB6FF40),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
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

                            // Feed
                            const Text(
                              'Feed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 50,
                              height: 3,
                              color: const Color(0xFFB6FF40),
                            ),
                            const SizedBox(height: 16),

                            // Пример карточек новостей
                            FutureBuilder<List<SportFeed>>(
                              future: _futureFeed,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Error: ${snapshot.error}',
                                    style: TextStyle(color: Colors.white),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Text(
                                    'No feed found.',
                                    style: TextStyle(color: Colors.white),
                                  );
                                }

                                final feeds = snapshot.data!;
                                return Column(
                                  children: feeds.take(2).map((feed) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: FeedCard(feed: feed),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ]);
                }
              })),
    );
  }
}
