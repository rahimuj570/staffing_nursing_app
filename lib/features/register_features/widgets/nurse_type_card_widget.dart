import 'package:flutter/material.dart';

class NurseTypeCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon; // Can pass an Image.asset or Icon here
  final bool isSelected;
  final VoidCallback onTap;

  const NurseTypeCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Styling variables matching the image colors
    const Color selectedBgColor = Color(0xFF1A458B); // Navy blue
    const Color unselectedBorderColor = Color(
      0xFF94A3B8,
    ); // Faint slate outline
    const Color unselectedTextColor = Color(0xFF64748B); // Muted grey text

    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ), // Smooth transition when selected
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? selectedBgColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? null
            : Border.all(color: unselectedBorderColor, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // 1. Left Custom Icon Area
              Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(
                    color: isSelected ? Colors.white : selectedBgColor,
                  ),
                ),
                child: SizedBox(width: 48, height: 48, child: icon),
              ),
              const SizedBox(width: 16),

              // 2. Text Information (Title & Subtitle)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white.withOpacity(0.8)
                            : unselectedTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Right Custom Radio Indicator
              _buildRadioIndicator(isSelected, selectedBgColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioIndicator(bool isSelected, Color activeColor) {
    if (isSelected) {
      return Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: Color(0xFF0F2547), // Darker contrast circle background
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      );
    } else {
      return Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF94A3B8), width: 2),
        ),
      );
    }
  }
}
