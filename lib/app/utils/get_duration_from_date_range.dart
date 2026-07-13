import 'package:intl/intl.dart';

String getDurationFromDateRange(String startTime, String endTime) {
  DateTime start = DateFormat("HH:mm:ss").parse(startTime);
  DateTime end = DateFormat("HH:mm:ss").parse(endTime);

  // If end is before start, assume it's the next day
  if (end.isBefore(start)) {
    end = end.add(Duration(days: 1));
  }

  Duration diff = end.difference(start);

  if (diff.inMinutes < 60) {
    return "${diff.inMinutes} mins";
  } else if (diff.inHours < 24) {
    return "${diff.inHours} hrs";
  } else if (diff.inDays < 30) {
    return "${diff.inDays} days";
  } else if (diff.inDays < 365) {
    int months = (diff.inDays / 30).floor();
    return "$months months";
  } else {
    int years = (diff.inDays / 365).floor();
    return "$years years";
  }
}
