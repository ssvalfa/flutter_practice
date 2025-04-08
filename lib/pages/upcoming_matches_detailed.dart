import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/league.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:flutter_application_1/utils/constants.dart';

class UpcomingMatchesPage extends StatelessWidget {
  final GameMatch match;

  const UpcomingMatchesPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final league = match.home.league;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "${match.home.title} vs ${match.guest.title}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMatchCard(league as League?),
          const SizedBox(height: 20),
          _buildMatchDetails(),
        ],
      ),
    );
  }

  Widget _buildMatchCard(League? league) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "${match.home.title} VS ${match.guest.title}",
            style: const TextStyle(
                color: Color.fromARGB(255, 251, 78, 78),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          if (league != null)
            Text(league.title, style: const TextStyle(color: Colors.green)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _teamLogo(
                  '${AppConstants.url}/api/files/${match.home.collectionId}/${match.home.id}/${match.home.img}',
                  "HOME"),
              const Text("- VS -",
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              _teamLogo(
                  '${AppConstants.url}/api/files/${match.guest.collectionId}/${match.guest.id}/${match.guest.img}',
                  "AWAY"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.green),
              const SizedBox(width: 5),
              Text(match.location.title,
                  style: const TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamLogo(String imageUrl, String label) {
    return Column(
      children: [
        Image.network(imageUrl, width: 50),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white54)),
      ],
    );
  }

  Widget _buildMatchDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Date",
              "${match.date.day}/${match.date.month}/${match.date.year}"),
          _buildDetailRow("Time",
              "${match.date.hour.toString().padLeft(2, '0')}:${match.date.minute.toString().padLeft(2, '0')}"),
          _buildDetailRow("Stadium", match.location.title),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
