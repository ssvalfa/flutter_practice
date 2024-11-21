// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.black,
              height: 200,
            ),
            Container(
              color: Colors.blue,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}