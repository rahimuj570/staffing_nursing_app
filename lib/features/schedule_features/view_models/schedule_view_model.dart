import 'package:flutter/material.dart';

class ScheduleViewModel extends ChangeNotifier {
  int tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }

  List<String> status = ['Upcoming', 'Completed', 'Cancelled'];
  String getStatus() => status[tabIndex];

  /////FOR DEMO PURPOSE
  bool isClockIn = false;

  void changeClockIn() {
    isClockIn = !isClockIn;
    notifyListeners();
  }
}
