import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_application_1/models/feed.dart';
import '../../services/pocketbase_service.dart';

class FeedDetailScreen extends StatefulWidget {
  final String id;
  const FeedDetailScreen({super.key, required this.id});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  late Future<SportFeed> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNews();
  }

  Future<SportFeed> fetchNews() async {
    try {
      final records =
          await pocketBaseService.pb.collection('sport_feed').getOne(widget.id);
      SportFeed news = SportFeed.fromJson(records.toJson());
      return news;
    } catch (e) {
      throw Exception('Failed to fetch news details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: FutureBuilder<SportFeed>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No news available.'));
            }

            final news = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row with back, share, and bookmark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.share_outlined),
                            SizedBox(width: 12),
                            Icon(Icons.bookmark_border),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Category label and date
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E4FB),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            news.type,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5F50E9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppConstants.formatDate(news.created),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Title
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '${AppConstants.url}/api/files/${news.collectionId}/${news.id}/${news.img}',
                        width: double.infinity,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Content
                    Html(data: news.content),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
