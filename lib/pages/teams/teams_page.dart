import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/models/team.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  late Future<List<Team>> futureData;
  int? _selectedLeagueIndex; // Индекс выбранной лиги

  List<Map<String, dynamic>> leagues = [
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
    futureData = loadData(null);
    super.initState();
  }

  Future<List<Team>> loadData(String? filter) async {
    final record = await pocketBaseService.pb
        .collection("sport_teams")
        .getFullList(filter: filter != null ? 'type="$filter"' : '');
    return record.map((el) => Team.fromJson(el.toJson())).toList();
  }

  void selectLeague(int index) {
    setState(() {
      if (_selectedLeagueIndex == index) {
        _selectedLeagueIndex = null;
        futureData = loadData(null);
      } else {
        _selectedLeagueIndex = index;
        futureData = loadData(leagues[index]["filter"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Teams", style: TextStyle(color: Colors.white)),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              _selectedLeagueIndex = null;
              futureData = loadData(null);
            });
          },
          label: const Text("Reset Filter")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: leagues.map((league) {
                  final isSelected =
                      _selectedLeagueIndex == leagues.indexOf(league);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilledButton.icon(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20)),
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          return isSelected
                              ? Colors.blueAccent
                              : Colors.grey[900]!;
                        }),
                      ),
                      icon: Icon(
                        league["icon"],
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => selectLeague(leagues.indexOf(league)),
                      label: Text(
                        league["label"],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(height: 16)), // Отступ после списка лиг
          FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white))),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                      child: Text('No teams available.',
                          style: TextStyle(color: Colors.white))),
                );
              } else {
                var teams = snapshot.data;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index % 2 == 1) {
                        return const SizedBox(
                            height: 10); // Отступ между элементами списка
                      }

                      final itemIndex = index ~/ 2;
                      if (itemIndex >= teams!.length) {
                        return null;
                      }

                      return ListTile(
                        onTap: () {
                          context.push('/teams/${teams[itemIndex].id}',
                              extra: {'title': teams[itemIndex].title});
                        },
                        leading: Image.network(
                          width: 40,
                          'https://restaurant-menu.fly.dev/api/files/sport_teams/${teams[itemIndex].id}/${teams[itemIndex].img}',
                        ),
                        title: Text(teams[itemIndex].title,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(teams[itemIndex].country,
                            style: TextStyle(color: Colors.grey)),
                        trailing:
                            const Icon(Icons.arrow_right, color: Colors.white),
                      );
                    },
                    childCount: teams!.length * 2 -
                        1, // Учитываем отступы между элементами
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
