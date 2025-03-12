import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import 'package:flutter_application_1/main.dart';
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
  List<String> types = ['football', 'basketball', 'kokboru', 'cybersport'];
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
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: types
                    .map((e) => TextButton(
                        onPressed: () {
                          setState(() {
                            futureData = loadData(e);
                          });
                        },
                        child: Text(e)))
                    .toList(),
              ),
            ),
          ),
          FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('No teams available.')),
                );
              } else {
                var teams = snapshot.data;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index % 2 == 1) {
                        // This handles the separator
                        return const SizedBox(height: 10);
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
                            'https://restaurant-menu.fly.dev/api/files/sport_teams/${teams[itemIndex].id}/${teams[itemIndex].img}'),
                        title: Text(teams[itemIndex].title),
                        subtitle: Text(teams[itemIndex].country),
                        trailing: const Icon(Icons.arrow_right),
                      );
                    },
                    childCount: teams!.length * 2 - 1, // Items + separators
                  ),
                );
              }
            },
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              child: Text("Reset filter"),
              onPressed: () {
                setState(() {
                  futureData = loadData(null);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class TeamPage extends StatelessWidget {
//   const TeamPage({super.key});

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
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: const TextField(
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               icon: Icon(Icons.search, color: Colors.green),
//               hintText: "Search...",
//               hintStyle: TextStyle(color: Colors.white54),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildLiveMatch(),
//           const SizedBox(height: 20),
//           _buildUpcomingMatches(),
//           const SizedBox(height: 20),
//           _buildTeamsList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLiveMatch() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "LIVE MATCHES",
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset("assets/real_madrid.png", width: 40),
//               const Text(
//                 "1 - 0",
//                 style: TextStyle(fontSize: 22, color: Colors.white),
//               ),
//               Image.asset("assets/barcelona.png", width: 40),
//             ],
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             "Old Trafford - Group H",
//             style: TextStyle(color: Colors.green),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUpcomingMatches() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "UPCOMING MATCHES",
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           const SizedBox(height: 10),
//           ListTile(
//             leading: Image.asset("assets/man_utd.png", width: 40),
//             title: const Text("M United VS Barcelona",
//                 style: TextStyle(color: Colors.white)),
//             subtitle: const Text("Tuesday, 9 Mar 2021, 05:00 AM",
//                 style: TextStyle(color: Colors.green)),
//             trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTeamsList() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "TEAMS",
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           const SizedBox(height: 10),
//           ListTile(
//             leading: Image.asset("assets/barcelona.png", width: 40),
//             title: const Text("FC Barcelona",
//                 style: TextStyle(color: Colors.white)),
//             subtitle: const Text("Upcoming Match - 9 Mar 2021",
//                 style: TextStyle(color: Colors.white54)),
//             trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
//           ),
//           ListTile(
//             leading: Image.asset("assets/espanyol.png", width: 40),
//             title: const Text("RCD Espanyol de Barcelona",
//                 style: TextStyle(color: Colors.white)),
//             subtitle: const Text("No Upcoming Match",
//                 style: TextStyle(color: Colors.white54)),
//             trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
