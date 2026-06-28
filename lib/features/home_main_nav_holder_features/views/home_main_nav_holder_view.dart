import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/features/home_main_nav_holder_features/view_models/main_home_nav_holder_view_model.dart';

class HomeMainNavHolderView extends StatelessWidget {
  const HomeMainNavHolderView({super.key});

  @override
  Widget build(BuildContext context) {
    int backPressCount = 0;

    Future<bool> onWillPop() async {
      final provider = context.read<MainHomeNavHolderViewModel>();
      if (provider.index != 0) {
        provider.changeIndex(0);
        backPressCount = 0;
        return false;
      }
      if (backPressCount == 0) {
        // First press → go to Home
        provider.changeIndex(0);
        backPressCount++;
        return false;
      } else if (backPressCount == 1) {
        // Second press → show SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Press back again to exit")),
        );
        backPressCount++;
        return false;
      } else {
        // Third press → exit app
        SystemNavigator.pop();
        return true;
      }
    }

    return Consumer<MainHomeNavHolderViewModel>(
      builder: (context, provider, child) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => onWillPop(),
        child: Scaffold(
          body: SafeArea(child: provider.getScreen()),
          bottomNavigationBar: BottomNavigationBar(
            type: .fixed,
            currentIndex: provider.index,
            onTap: (value) {
              provider.changeIndex(value);
            },

            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(RemixIcons.home_6_line),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(RemixIcons.search_2_line),
                label: 'Shifts',
              ),
              BottomNavigationBarItem(
                icon: Icon(RemixIcons.calendar_line),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(RemixIcons.mail_line),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(RemixIcons.account_circle_2_line),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
