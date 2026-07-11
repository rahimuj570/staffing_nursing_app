import 'package:intl/intl.dart';

String formatTime(String timeString) {
  // Parse the string into DateTime
  DateTime time = DateFormat("HH:mm:ss.SSS").parse(timeString);

  // Format into desired output
  return DateFormat("h:mm a").format(time);
}

void main() {
  String formatted = formatTime("04:15:34.096");
  print(formatted); // 4:15 AM
}
