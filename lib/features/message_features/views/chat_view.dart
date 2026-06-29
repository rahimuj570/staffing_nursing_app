import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/message_features/widgets/chat_bubble_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController chatTEC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
            ),
            SizedBox(width: 8.w),
            Stack(
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.asset(AppAssets.nurseDp, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Text(
              'Savannah Nguyen',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: const [
          // Incoming Group
          ChatBubbleWidget(
            message:
                "Subtract undo boolean arrow thumbnail hand duplicate object.",
            isMe: false,
            time: "3:53 PM",
          ),
          ChatBubbleWidget(
            message: "Fresh sauce pesto pepperoni steak",
            isMe: false,
            time: "3:53 PM",
          ),
          ChatBubbleWidget(
            isSeen: true,
            message: "Green lovers pan roll dolor",
            isMe: true,
            time: "3:53 PM",
          ),
          ChatBubbleWidget(
            message: "Sautéed style buffalo olives black",
            isMe: true,
            time: "3:53 PM",
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: .only(right: 20.w, left: 20.w, bottom: 10.h),
          child: Row(
            children: [
              Expanded(
                child: customTextFieldWidget(
                  label: '',
                  controller: chatTEC,
                  textInputType: .text,
                  placeHolder: 'Type a message....',
                ),
              ),
              SizedBox(width: 6.w),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.themeColorLight,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                icon: Padding(
                  padding: EdgeInsets.all(4.0.r),
                  child: Icon(Icons.send_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
