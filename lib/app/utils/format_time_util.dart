import 'package:intl/intl.dart';

String formatTime(String timeString) {
  late DateTime time;
  if (timeString.contains('.')) {
    time = DateFormat("HH:mm:ss.SSS").parse(timeString);
  } else {
    time = DateFormat("HH:mm:ss").parse(timeString);
  }
  // Parse the string into DateTime

  // Format into desired output
  return DateFormat("h:mm a").format(time);
}
