import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepIndicatorWidget extends StatelessWidget {
  final int totalSteps;
  final int
  currentStep; // 0-indexed (e.g., if step 1 is active, currentStep = 1)
  final Color activeColor;
  final Color inactiveColor;

  const StepIndicatorWidget({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor = const Color(0xFF1A458B), // Matching the deep navy blue
    this.inactiveColor = const Color(
      0xFFE2E8F0,
    ), // Matching the light grey border
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        return Row(
          children: [
            // 1. The Step Node
            _buildStepNode(index),

            // 2. The Connecting Line (Only add if it's not the last step)
            if (index < totalSteps - 1) _buildLine(index),
          ],
        );
      }),
    );
  }

  Widget _buildStepNode(int index) {
    double size = 32.0.r;

    // State A: Completed Step
    if (index < currentStep) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      );
    }

    // State B: Current/Active Step
    if (index == currentStep) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: activeColor, width: 1.5),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    // State C: Unvisited/Inactive Step
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: inactiveColor, width: 1.5),
      ),
    );
  }

  Widget _buildLine(int index) {
    // Determine the color of the connecting line based on the next node's status
    final isLineCompleted = index < currentStep;

    return Container(
      width: 40, // Adjust this width to change the spacing between steps
      height: 2,
      color: isLineCompleted ? activeColor : inactiveColor,
    );
  }
}
