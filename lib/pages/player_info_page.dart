import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/player.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/feed_card.dart';
import 'package:flutter_application_1/models/feed.dart';

class PlayerProfilePage extends StatelessWidget {
  final Player player;
  final List<GameMatch> matches;
  final List<SportFeed> feeds;

  const PlayerProfilePage({
    super.key,
    required this.player,
    required this.matches,
    required this.feeds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(player.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPlayerHeader(),
          const SizedBox(height: 20),
          _buildMatchList(),
          const SizedBox(height: 20),
          _buildNewsSection(), // заглушка для новостей
        ],
      ),
    );
  }

  Widget _buildPlayerHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              '${AppConstants.url}/api/files/${player.collectionId}/${player.id}/${player.img}',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(player.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 5),
                Text("Number: ${player.number}",
                    style: const TextStyle(color: Colors.green)),
                Text("Position: ${player.position}",
                    style: const TextStyle(color: Colors.green)),
                Text("Country: ${player.country}",
                    style: const TextStyle(color: Colors.green)),
                Text("Team: ${player.team.title}",
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Last Matches",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          ...matches.map((match) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${match.home.title} vs ${match.guest.title}",
                        style: const TextStyle(color: Colors.white70)),
                    Text("${match.homeScore}:${match.guestScore}",
                        style: const TextStyle(color: Colors.green)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Related News",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          if (feeds.isEmpty)
            const Text("No news available.",
                style: TextStyle(color: Colors.white54))
          else
            ...feeds.map((feed) => FeedCard(feed: feed)),
        ],
      ),
    );
  }
}
