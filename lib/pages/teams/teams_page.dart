import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/team.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
// ignore: unused_import

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  late Future<List<Team>> futureData;

  @override
  void initState() {
    futureData = loadData();
    super.initState();
  }

  Future<List<Team>> loadData() async {
    final record =
        await pocketBaseService.pb.collection("sport_teams").getFullList();
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
      body: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No teams available.'));
            } else {
              var teams = snapshot.data;
              return ListView.builder(
                  itemCount: teams!.length,
                  itemBuilder: (context, index) => ListTile(
                        onTap: () {},
                        leading: Image.network(
                            width: 40,
                            'https://restaurant-menu.fly.dev/api/files/sport_teams/${teams[index].id}/${teams[index].img}'),
                        title: Text(teams[index].title),
                        subtitle: Text(teams[index].country),
                        trailing: Icon(Icons.arrow_right),
                      ));
            }
          }),
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
