import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/widgets/upcoming_card.dart';

class UpcomingMatchesListPage extends StatelessWidget {
  const UpcomingMatchesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = [
      {
        'homeTeam': 'Arsenal',
        'awayTeam': 'Dortmund',
        'homeTeamLogo': 'assets/arsenal_logo.png',
        'awayTeamLogo': 'assets/dortmund_logo.png',
        'date': 'Tuesday, 9 Mar 2021',
        'time': '05.00 am',
      },
      {
        'homeTeam': 'Bayern',
        'awayTeam': 'Man United',
        'homeTeamLogo': 'assets/bayern_logo.png',
        'awayTeamLogo': 'assets/man_united_logo.png',
        'date': 'Tuesday, 16 Mar 2021',
        'time': '05.00 am',
      },
      {
        'homeTeam': 'Liverpool',
        'awayTeam': 'Barcelona',
        'homeTeamLogo': 'assets/liverpool_logo.png',
        'awayTeamLogo': 'assets/barcelona_logo.png',
        'date': 'Wednesday, 24 Mar 2021',
        'time': '05.00 am',
      },
      {
        'homeTeam': 'PSG',
        'awayTeam': 'Chelsea',
        'homeTeamLogo': 'assets/psg_logo.png',
        'awayTeamLogo': 'assets/chelsea_logo.png',
        'date': 'Tuesday, 30 Mar 2021',
        'time': '05.00 am',
      },
      {
        'homeTeam': 'Real Madrid',
        'awayTeam': 'Juventus',
        'homeTeamLogo': 'assets/real_madrid_logo.png',
        'awayTeamLogo': 'assets/juventus_logo.png',
        'date': 'Thursday, 8 Apr 2021',
        'time': '05.00 am',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Upcoming Matches'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: UpcomingCard(
                  leagueLogo1: match['homeTeamLogo']!,
                  leagueLogo2: match['awayTeamLogo']!,
                  matchTitle: '${match['homeTeam']} VS ${match['awayTeam']}',
                  matchDate: '${match['date']} · ${match['time']}',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
