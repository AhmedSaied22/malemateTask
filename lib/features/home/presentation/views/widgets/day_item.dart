import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mealmate/core/ui/app_colors.dart';

class DayItem extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  const DayItem({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dayNumber = day.day.toString();
    final dayAbbreviation = DateFormat('EEE').format(day);

    final textColor = isSelected ? Colors.white : AppColors.hintColor;
    final backgroundColor = isSelected ? Colors.green : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dayNumber,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dayAbbreviation,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
