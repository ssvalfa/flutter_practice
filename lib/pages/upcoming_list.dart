import 'package:flutter/material.dart';

class UpcomingMatchesListPage extends StatelessWidget {
  const UpcomingMatchesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Match data structure directly defined within the build method
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
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upcoming Matches',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    final match = matches[index];

                    // Match card implementation directly in the list builder
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade800,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Team logos
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.black26,
                                    child: Image.asset(
                                      match['homeTeamLogo']!,
                                      height: 45,
                                      errorBuilder:
                                          (context, error, stackTrace) => Text(
                                              match['homeTeam']!
                                                  .substring(0, 1),
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.black26,
                                    child: Image.asset(
                                      match['awayTeamLogo']!,
                                      height: 45,
                                      errorBuilder:
                                          (context, error, stackTrace) => Text(
                                              match['awayTeam']!
                                                  .substring(0, 1),
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              // Match details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${match['homeTeam']} VS ${match['awayTeam']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${match['date']} · ${match['time']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
