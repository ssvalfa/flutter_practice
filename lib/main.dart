import 'package:flutter/material.dart';
import 'package:flutter_application_1/router.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  runApp(const SportlyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await pocketBaseService.initAuth();
}

class SportlyApp extends StatelessWidget {
  const SportlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
        listTileTheme: ListTileThemeData(
          tileColor: const Color.fromARGB(255, 44, 44, 46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      theme: ThemeData(
        useMaterial3: true,
        listTileTheme: ListTileThemeData(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          const TextTheme(

              // titleLarge: TextStyle(fontWeight: FontWeight.w400),
              ),
        ),
      ),
      routerConfig: router,
    );
  }
}
