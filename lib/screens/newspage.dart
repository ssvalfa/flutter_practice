import 'package:flutter/material.dart';

class Newspage extends StatelessWidget {
  static const String route = '/news';
  const Newspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
    );
  }
}
