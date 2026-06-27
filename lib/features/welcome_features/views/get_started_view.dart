import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/auth_features/views/login_views.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 2. Main Content Layout
          Column(
            children: [
              // Top Section: Beautiful scaled hero image
              Expanded(
                flex: 12, // Gives the image ample room to breathe vertically
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: 54
                          .h, // Controls the exact whitespace gap above the nurse's hair
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        AppAssets.getStartedHero,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 54.h,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 10.h, // Height of the top fade zone
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors
                                  .white, // Fades completely from solid white background color
                              Colors.white.withValues(alpha: 0.7),
                              Colors.white.withValues(
                                alpha: 0.0,
                              ), // Melts seamlessly into the image
                            ],
                            stops: const [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Soft white gradient overlay at the bottom to blend seamlessly into text
                    Container(
                      height:
                          140.h, // Slightly taller blend for an immersive look
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.7),
                            Colors.white,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Section: Typography and Action Button
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      // Main Headline
                      Text(
                        'Your Next Nursing\nOpportunity Starts Here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0D2352), // Deep navy blue
                          height: 1.25,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Subtitle text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: Text(
                          'Find shifts, manage your schedule, and unlock new opportunities with LAC Staffing.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF7E8CA0), // Muted slate gray
                            height: 1.5,
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Primary CTA Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(LoginViews());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF0F2D5C,
                            ), // Dark Navy
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.arrow_forward, size: 18.sp),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ), // Clear of native OS gesture navigation bars
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
