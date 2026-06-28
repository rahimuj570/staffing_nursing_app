import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;
  final bool isSeen;

  const ChatBubbleWidget({
    required this.message,
    required this.isMe,
    required this.time,
    super.key,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: isMe ? AppColors.themeColorLight : AppColors.greyLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.circular(0),
            bottomRight: isMe
                ? const Radius.circular(0)
                : Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black45,
                    fontSize: 12.sp,
                  ),
                ),
                if (isMe)
                  Padding(
                    padding: .only(left: 4.w),
                    child: Icon(
                      Icons.done_all,
                      size: 16.r,
                      color: isSeen ? AppColors.themeColorDark : Colors.white70,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
