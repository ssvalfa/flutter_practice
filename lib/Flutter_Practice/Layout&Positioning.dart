import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AllInOne UI Kit"),
        actions: [
          Switch(
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopButtons(context),
            const SizedBox(height: 30),
            const Text(
              "Themes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildThemeList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2, // Два элемента в строке
      crossAxisSpacing: 15, // Расстояние между столбцами
      mainAxisSpacing: 15, // Расстояние между строками
      childAspectRatio: 1.6, // Прямоугольная форма
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTopButton(
            context, "Default Theme", Icons.phone_android, Colors.teal),
        _buildTopButton(context, "Full Apps", Icons.apps, Colors.purple),
        _buildTopButton(context, "Integration", Icons.public, Colors.orange),
        _buildTopButton(context, "Dashboard", Icons.dashboard, Colors.amber),
      ],
    );
  }

  Widget _buildTopButton(
      BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(title: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(4, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeList(BuildContext context) {
    final themes = [
      {
        "title": "File Manager",
        "screens": 1,
        "color": Colors.orange,
        "icon": Icons.insert_drive_file
      },
      {
        "title": "Exercise Tips",
        "screens": 2,
        "color": Colors.green,
        "icon": Icons.fitness_center
      },
      {
        "title": "Food Recipe",
        "screens": 3,
        "color": Colors.blue,
        "icon": Icons.restaurant_menu
      },
      {
        "title": "Gym",
        "screens": 4,
        "color": Colors.lightBlue,
        "icon": Icons.sports_gymnastics
      },
      {
        "title": "e-wallet",
        "screens": 5,
        "color": Colors.amber,
        "icon": Icons.account_balance_wallet
      },
    ];

    return Column(
      children: themes.map((theme) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(title: theme["title"] as String),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(4, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme["color"] as Color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(theme["icon"] as IconData, color: Colors.white),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        theme["title"] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Theme ${theme["screens"]} Screens",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: theme["color"] as Color,
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 16),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          "This is a detailed page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}