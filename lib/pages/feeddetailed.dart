import 'package:flutter/material.dart';

class FeedDetailed extends StatelessWidget {
  const FeedDetailed({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          // Image Section
          Stack(
            children: [
              Image.asset(
                'https://placehold.co/400x400.png', // Replace with your asset image path
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "2 hours ago",
                    ),
                    Spacer(),
                    Icon(Icons.comment, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "27",
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.visibility, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "916",
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "A ruggedly beautiful quarantine site",
                ),
                SizedBox(height: 16),
                Text(
                  "Perspicitatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
                ),
                SizedBox(height: 16),
                Text(
                  "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur amet, consectetur lorem ipsum dolor accusantium doloremque.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
