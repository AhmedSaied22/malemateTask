import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/core/ui/app_styles_fonts.dart';

class DayItem extends StatelessWidget {
  final DateTime? day;
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (day == null)
              _buildAllText(context)
            else
              _buildDateInfo(day!, context),
          ],
        ),
      ),
    );
  }

  Widget _buildAllText(BuildContext context) {
    return Text(
      'All',
      style: AppFonts.style(
          context: context,
          size: AppFonts.sizes.s16,
          weight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.dateTextColor),
    );
  }

  Widget _buildDateInfo(DateTime date, BuildContext context) {
    return Column(
      children: [
        Text(
          date.day.toString(),
          style: AppFonts.style(
              context: context,
              size: AppFonts.sizes.s18,
              weight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.dateTextColor),
        ),
        Text(
          DateFormat('EEE').format(date),
          style: AppFonts.style(
              context: context,
              size: AppFonts.sizes.s14,
              weight: FontWeight.w400,
              fontFamily: AppFonts.secondaryFont,
              color: isSelected ? Colors.white : AppColors.dateTextColor),
        ),
      ],
    );
  }
}
