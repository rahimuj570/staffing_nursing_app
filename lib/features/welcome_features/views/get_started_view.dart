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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // 1. Background Gradient
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.0, -0.87.h),
                        radius: 1.2.r,
                        colors: [
                          Color(0xff92BEFF), // Light blue center glow
                          Colors.white, // Fades to solid white
                        ],
                        stops: [0.0, 0.8],
                      ),
                    ),
                  ),
                ),

                // 2. Main Content Layout
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      // Top half: Nurse image with a bottom fade overlay
                      Expanded(
                        flex: 11,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Image asset
                            Positioned.fill(
                              child: Image.asset(
                                AppAssets.getStartedHero,
                                fit: Alignment.topCenter == Alignment.topCenter
                                    ? BoxFit.contain
                                    : BoxFit.cover,
                              ),
                            ),
                            // Soft white gradient overlay at the bottom of the image to blend it smoothly
                            Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.0),
                                    Colors.white.withValues(alpha: 0.8),
                                    Colors.white,
                                  ],
                                  stops: const [0.0, 0.6, 1.0],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom half: Typography and Action Button
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Main Headline
                              Text(
                                'Your Next Nursing\nOpportunity Starts Here',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0D2352), // Deep navy blue
                                  height: 1.25,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Subtitle text
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w,
                                ),
                                // style: TextStyle(
                                //   fontSize: 14,
                                //   color: Color(0xFF7E8CA0), // Muted slate gray
                                //   height: 1.5,
                                // ),
                                child: Text(
                                  'Find shifts, manage your schedule, and unlock new opportunities with LAC Staffing.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                              const Spacer(),
                              // Primary CTA Button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
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
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Get Started',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_forward, size: 18),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ), // Safe spacing for bottom navigation lines
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
