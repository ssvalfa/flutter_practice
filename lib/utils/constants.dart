import 'package:intl/intl.dart';

class AppConstants {
  static const String url = "https://restaurant-menu.fly.dev";
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
