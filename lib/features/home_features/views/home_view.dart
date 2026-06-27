import 'package:flutter/material.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBarWidget());
  }
}
