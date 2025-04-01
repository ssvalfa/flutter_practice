import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpcomingCard extends StatelessWidget {
  final String leagueLogo1;
  final String leagueLogo2;
  final String matchTitle;
  final String matchDate;
  final DateTime date;

  const UpcomingCard(
      {super.key,
      required this.leagueLogo1,
      required this.leagueLogo2,
      required this.matchTitle,
      required this.date,
      required this.matchDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/upcoming');
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
                backgroundImage: NetworkImage(leagueLogo1), // Placeholder
                backgroundColor:
                    Colors.white24, // На случай отсутствия изображения
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(leagueLogo2), // Placeholder
                backgroundColor:
                    Colors.white24, // На случай отсутствия изображения
              ),
              const SizedBox(width: 16),
              // Текст
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      matchTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      matchDate,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              date.isAfter(DateTime.now()) ? Text("After") : Text("Before")
            ],
          ),
        ));
  }
}
