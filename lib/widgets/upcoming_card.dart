import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:go_router/go_router.dart';

class UpcomingCard extends StatelessWidget {
  final GameMatch match;

  const UpcomingCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/match/${match.id}');
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Лого лиги / команды
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  '${AppConstants.url}/api/files/${match.home.collectionId}/${match.home.id}/${match.home.img}',
                ),
                backgroundColor:
                    Colors.white24, // На случай отсутствия изображения
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                    '${AppConstants.url}/api/files/${match.guest.collectionId}/${match.guest.id}/${match.guest.img}'), // Placeholder
                backgroundColor:
                    Colors.white24, // На случай отсутствия изображения
              ),
              const SizedBox(width: 16),
              // Текст
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${match.home.title} VS ${match.guest.title}'),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.formatDate(match.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Text(
                match.date.isAfter(DateTime.now()) ? "Upcoming" : "Finished",
                style: TextStyle(
                  color: match.date.isAfter(DateTime.now())
                      ? Colors.greenAccent
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}
