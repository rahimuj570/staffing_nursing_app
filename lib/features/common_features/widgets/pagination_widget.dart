import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class PaginationWidget extends StatelessWidget {
  final int totalPages;
  final VoidCallback fetchPreviousPage;
  final VoidCallback fetchNextPage;
  final String? previous;
  final String? next;

  const PaginationWidget({
    super.key,
    required this.totalPages,
    required this.fetchPreviousPage,
    required this.fetchNextPage,
    this.previous,
    this.next,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        if (totalPages > 1)
          Row(
            mainAxisAlignment: .spaceAround,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.themeColorLight,
                  foregroundColor: Colors.white,
                ),
                onPressed: previous == null ? null : fetchPreviousPage,
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              IconButton(
                onPressed: next == null ? null : fetchNextPage,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.themeColorLight,
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
