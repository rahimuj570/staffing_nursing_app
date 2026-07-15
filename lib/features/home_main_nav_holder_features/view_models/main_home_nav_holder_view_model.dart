import 'package:flutter/material.dart';
import 'package:staffing/features/home_features/views/home_view.dart';
import 'package:staffing/features/message_features/views/message_view.dart';
import 'package:staffing/features/my_profile_features/views/my_profile_view.dart';
import 'package:staffing/features/schedule_features/views/schedule_view.dart';
import 'package:staffing/features/shift_features/views/shift_view.dart';

class MainHomeNavHolderViewModel extends ChangeNotifier {
  int index = 0;

  void changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  Widget getScreen() {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return ShiftView();
      case 2:
        return ScheduleView();
      case 4:
        return MessageView();
      case 3:
        return MyProfileView();
      default:
        return const Center(child: Text('No Screen'));
    }
  }
}
