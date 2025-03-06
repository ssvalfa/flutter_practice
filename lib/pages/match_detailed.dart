import 'package:flutter/material.dart';

class MatchDetailPage extends StatefulWidget {
  const MatchDetailPage({super.key});

  @override
  State<MatchDetailPage> createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF212121), // Тёмный фон по макету
      body: SafeArea(
        child: Stack(
          children: [
            // Можно добавить фоновую графику, градиент или узор
            // Чтобы повторить скруглённые паттерны, можно использовать CustomPaint
            Positioned.fill(
              child: Container(
                // Пример градиента (замените на нужный):
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
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        // Заголовок: AppBar-замена
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Кнопка "назад"
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const Text(
                              'Match',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Иконки справа
                            const Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 16),
                                Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Text(
                          'Live Matches',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // "Карточка" основного счёта

                        const SizedBox(height: 24),

                        // Табы: Statistics / Lineup / Timeline
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: const Color(0xFF393939),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white54,
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            tabs: const [
                              Tab(text: 'Statistics'),
                              Tab(text: 'Lineup'),
                              Tab(text: 'Timeline'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Содержимое под табами
                        SizedBox(
                          height: 400, // Примерная высота для контента
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildStatisticsTab(),
                              // Здесь замените на ваш контент для lineup
                              const Center(
                                child: Text(
                                  'Lineup Content',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              // Здесь замените на ваш контент для timeline
                              const Center(
                                child: Text(
                                  'Timeline Content',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Нижняя панель навигации (пример)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                            // Можно стилизовать под ваш дизайн
                            border: Border(
                              top: BorderSide(color: Colors.white24),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildBottomNavItem(
                                icon: Icons.home,
                                label: 'Home',
                                isActive: true,
                              ),
                              _buildBottomNavItem(
                                icon: Icons.newspaper,
                                label: 'News',
                                isActive: false,
                              ),
                              _buildBottomNavItem(
                                icon: Icons.radio,
                                label: 'Radio',
                                isActive: false,
                              ),
                              _buildBottomNavItem(
                                icon: Icons.person,
                                label: 'Profile',
                                isActive: false,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildStatRow(
            leftValue: '1',
            statTitle: 'Shots on Target',
            rightValue: '0',
          ),
          _buildStatRow(
            leftValue: '1',
            statTitle: 'Shots off Target',
            rightValue: '9',
          ),
          _buildStatRow(
            leftValue: '3',
            statTitle: 'Blocked Shots',
            rightValue: '3',
          ),
          _buildStatRow(
            leftValue: '44',
            statTitle: 'Possession (%)',
            rightValue: '56',
          ),
          _buildStatRow(
            leftValue: '4',
            statTitle: 'Corner Kicks',
            rightValue: '6',
          ),
          _buildStatRow(
            leftValue: '3',
            statTitle: 'Offsides',
            rightValue: '1',
          ),
          _buildStatRow(
            leftValue: '44',
            statTitle: 'Fouls',
            rightValue: '56',
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required String leftValue,
    required String statTitle,
    required String rightValue,
  }) {
    // Пример реализации «полоски» или просто текстовых элементов
    // Можно сделать прогресс бар, если хотите визуализировать разницу.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        // Можно стилизовать бэкграунд, если требуется
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Левая сторона
            Text(
              leftValue,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Название статы
            Expanded(
              child: Center(
                child: Text(
                  statTitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            // Правая сторона
            Text(
              rightValue,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.white : Colors.white54,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
