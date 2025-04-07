import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_application_1/models/feed.dart';

import '../../services/pocketbase_service.dart';

class FeedDetailScreen extends StatefulWidget {
  final String id;
  const FeedDetailScreen({super.key, required this.id});

  @override
  State<FeedDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<FeedDetailScreen> {
  late Future<SportFeed> _newsFuture;

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
  void initState() {
    super.initState();
    _newsFuture = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<SportFeed>(
          future: _newsFuture,
          builder: (context, snapshot) {
            return Text(snapshot.hasData ? snapshot.data!.type : 'Loading....');
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No news available.'));
            } else {
              final news = snapshot.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display just one image
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.9,
                      child: Image.network(
                        '${AppConstants.url}/api/files/${news.collectionId}/${news.id}/${news.img}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: height / 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // This can be omitted or customized as per your need
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppConstants.formatDate(news.created),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 6),
                          Html(
                            data: news.content,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
