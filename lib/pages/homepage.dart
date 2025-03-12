import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_application_1/pages/teams/teams_page.dart';
import 'package:flutter_application_1/widgets/live_card.dart';
// import 'package:flutter_application_1/widgets/league_Icons.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';
import 'package:go_router/go_router.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // int _leagueIndex = 0;
  // List<Map> leagues = [
  //   {"label": "UEFA Champions\nleague", "icon": Icons.sports_soccer},
  //   {"label": "MLS", "icon": Icons.sports_soccer_outlined},
  //   {"label": "NBA", "icon": Icons.sports_basketball},
  //   {"label": "Premier League", "icon": Icons.sports_volleyball}
  // ];
  // void selectLeague(int index) {
  //   setState(() {
  //     _leagueIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF212121), // Тёмный фон
      body: SafeArea(
        child: Stack(
          children: [
            // Опционально: фон или градиент
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF212121),
                      Color(0xFF1A1A1A),
                    ],
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
                      color: const Color(0xFFB6FF40), // Пример светло-зелёного
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
                    UpcomingCard(
                      leagueLogo1: 'https://placehold.co/6x6.png', // пример
                      leagueLogo2: 'https://placehold.co/6x6.png',
                      matchTitle: 'Aersenal VS Dortmund',
                      matchDate: 'Tuesday, 9 Mar 2021, 05.00 am',
                    ),
                    const SizedBox(height: 8),

                    UpcomingCard(
                      leagueLogo1: 'https://placehold.co/8x8.png', // пример
                      leagueLogo2: 'https://placehold.co/8x8.png',
                      matchTitle: 'Bayem VS Man United',
                      matchDate: 'Tuesday, 16 Mar 2021, 05.00 am',
                    ),
                    const SizedBox(height: 24),

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
                    _buildFeedCard(
                      tag: 'Women’s League',
                      title: 'As it happened: Spain win final',
                      subtitle:
                          'Details and reaction after Spain beat France 2-0 in the first women’s national league final',
                      imageUrl: 'https://placehold.co/600x400.png', // заглушка
                    ),
                    const SizedBox(height: 16),
                    _buildFeedCard(
                      tag: 'World Soccer',
                      title: 'Quarter - Finals ties set',
                      subtitle:
                          'Details and reaction after Spain beat France 2-0 in the first women’s national league final',
                      imageUrl: 'https://placehold.co/600x400.png', // заглушка
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет карточки новостей (Feed)
  Widget _buildFeedCard({
    required String tag,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('/feeddetailed'); // Переход на страницу с деталями
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Изображение сверху
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image,
                      color: Colors.white, size: 50),
                ),
              ),
            ),
            // Контент карточки
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Тег / категория
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Заголовок новости
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Подзаголовок
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
