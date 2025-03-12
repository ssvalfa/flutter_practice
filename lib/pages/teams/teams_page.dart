import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/models/team.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/widgets/league_Icons.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  late Future<List<Team>> futureData;
  int _selectedLeagueIndex = 0; // Индекс выбранной лиги

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
      _selectedLeagueIndex = index;
      futureData = loadData(leagues[index]["filter"]);
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: leagues.length,
                itemBuilder: (context, index) {
                  final league = leagues[index];
                  final isSelected = _selectedLeagueIndex == index;

                  return GestureDetector(
                    onTap: () => selectLeague(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.blueAccent : Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(league["icon"], color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            league["label"],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedLeagueIndex = 0;
                    futureData = loadData(null);
                  });
                },
                child: const Text("Reset filter"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// // ignore: unused_import
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_application_1/models/team.dart';
// import 'package:flutter_application_1/services/pocketbase_service.dart';
// import 'package:flutter_application_1/widgets/league_Icons.dart';

// class TeamsPage extends StatefulWidget {
//   const TeamsPage({super.key});

//   @override
//   State<TeamsPage> createState() => _TeamsPageState();
// }

// class _TeamsPageState extends State<TeamsPage> {
//   late Future<List<Team>> futureData;
//   List<String> types = ['football', 'basketball', 'kokboru', 'cybersport'];
//   @override
//   void initState() {
//     futureData = loadData(null);
//     super.initState();
//   }

//   Future<List<Team>> loadData(String? filter) async {
//     final record = await pocketBaseService.pb
//         .collection("sport_teams")
//         .getFullList(filter: filter != null ? 'type="$filter"' : '');
//     return record.map((el) => Team.fromJson(el.toJson())).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: types
//                     .map((e) => TextButton(
//                         onPressed: () {
//                           setState(() {
//                             futureData = loadData(e);
//                           });
//                         },
//                         child: Text(e)))
//                     .toList(),
//               ),
//             ),
//           ),
//           FutureBuilder(
//             future: futureData,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const SliverToBoxAdapter(
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               } else if (snapshot.hasError) {
//                 return SliverToBoxAdapter(
//                   child: Center(child: Text('Error: ${snapshot.error}')),
//                 );
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const SliverToBoxAdapter(
//                   child: Center(child: Text('No teams available.')),
//                 );
//               } else {
//                 var teams = snapshot.data;
//                 return SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       if (index % 2 == 1) {
//                         // This handles the separator
//                         return const SizedBox(height: 10);
//                       }

//                       final itemIndex = index ~/ 2;
//                       if (itemIndex >= teams!.length) {
//                         return null;
//                       }

//                       return ListTile(
//                         onTap: () {
//                           context.push('/teams/${teams[itemIndex].id}',
//                               extra: {'title': teams[itemIndex].title});
//                         },
//                         leading: Image.network(
//                             width: 40,
//                             'https://restaurant-menu.fly.dev/api/files/sport_teams/${teams[itemIndex].id}/${teams[itemIndex].img}'),
//                         title: Text(teams[itemIndex].title),
//                         subtitle: Text(teams[itemIndex].country),
//                         trailing: const Icon(Icons.arrow_right),
//                       );
//                     },
//                     childCount: teams!.length * 2 - 1, // Items + separators
//                   ),
//                 );
//               }
//             },
//           ),
//           SliverToBoxAdapter(
//             child: ElevatedButton(
//               child: Text("Reset filter"),
//               onPressed: () {
//                 setState(() {
//                   futureData = loadData(null);
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
