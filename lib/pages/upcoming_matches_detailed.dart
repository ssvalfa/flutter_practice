import 'package:flutter/material.dart';

class UpcomingMatchesPage extends StatelessWidget {
  const UpcomingMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Upcoming Matches",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMatchCard(),
          const SizedBox(height: 20),
          _buildMatchDetails(),
        ],
      ),
    );
  }

  Widget _buildMatchCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Manchester United VS Barcelona",
            style: TextStyle(
                color: Color.fromARGB(255, 251, 78, 78),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text("UEFA Champions League",
              style: TextStyle(color: Colors.green)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _teamLogo("https://placehold.co/50x50.png", "HOME"),
              const Text(
                "- VS -",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              _teamLogo("assets/barcelona.png", "AWAY"),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.green),
              SizedBox(width: 5),
              Text("Old Trafford", style: TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamLogo(String assetPath, String label) {
    return Column(
      children: [
        Image.network(assetPath, width: 50),
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
          _buildTabBar(),
          const SizedBox(height: 10),
          _buildDetailRow("Date", "Tuesday, 9 March 2025"),
          _buildDetailRow("Time", "05:00 AM"),
          _buildDetailRow("Stadium", "Old Trafford"),
          _buildDetailRow("Referee", "Michael Oliver"),
          _buildDetailRow("Weather", "Cloudy, 12°C"),
          _buildDetailRow("Tickets Available", "Yes"),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        _tabButton("Match Info", isActive: true),
        _tabButton("Lineup"),
        _tabButton("Preview"),
      ],
    );
  }

  Widget _tabButton(String title, {bool isActive = false}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
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
