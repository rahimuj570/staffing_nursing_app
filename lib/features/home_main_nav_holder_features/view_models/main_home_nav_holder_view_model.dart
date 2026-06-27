import 'package:flutter/material.dart';
import 'package:staffing/features/home_features/views/home_view.dart';
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
        return const Placeholder();
      case 3:
        return const Placeholder();
      case 4:
        return const Placeholder();
      default:
        return const Placeholder();
    }
  }
}
