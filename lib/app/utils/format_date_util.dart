import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return DateFormat('MMM d, y').format(date);
}

void main() {
  String formatted = formatDate("2026-07-01");
  print(formatted); // Jul 1, 2026
}
