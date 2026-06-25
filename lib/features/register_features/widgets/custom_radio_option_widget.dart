import 'package:flutter/material.dart';

class CustomRadioOptionWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T?> onChanged;

  const CustomRadioOptionWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    // Exact colors from the design snippet
    const Color activeBorderColor = Color(0xFF1D478A); // Thick Navy Outer ring
    const Color activeDotColor = Color(0xFF1D478A); // Center Dot
    const Color inactiveColor = Color(0xFF7C8BA1); // Muted Slate Gray
    const Color textColor = Color(0xFF5C6E88); // Soft text navy/gray

    return InkWell(
      onTap: () => onChanged(value),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom Radio Circle Structure
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? activeBorderColor : inactiveColor,
                  width: isSelected ? 2.5 : 2.0, // Thicker border when selected
                ),
                color: Colors.transparent,
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: isSelected ? 13 : 0,
                  height: isSelected ? 13 : 0,
                  decoration: const BoxDecoration(
                    color: activeDotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Option Label Text
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
