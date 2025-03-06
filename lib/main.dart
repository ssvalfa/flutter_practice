import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/router.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';

Future<void> main() async {
  runApp(SportlyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await pocketBaseService.initAuth();
}

class SportlyApp extends StatelessWidget {
  const SportlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routerConfig: router,
    );
  }
}
