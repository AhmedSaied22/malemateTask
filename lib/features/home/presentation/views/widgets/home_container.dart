import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/core/utils/enums.dart';
import 'package:mealmate/features/home/presentation/views/widgets/calorie_filter_dialog.dart';
import 'package:mealmate/features/home/presentation/views/widgets/day_filter.dart';

class HomeViewGreenContainer extends StatelessWidget {
  final List<DateTime?> days;
  final FilterType filterType;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDaySelected;
  final ValueChanged<DateTime> onDatePicked;
  final RangeValues calorieRange;
  final ValueChanged<RangeValues> onCalorieFilter;

  const HomeViewGreenContainer({
    super.key,
    required this.days,
    required this.filterType,
    required this.selectedDate,
    required this.onDaySelected,
    required this.onDatePicked,
    required this.onCalorieFilter,
    required this.calorieRange,
  });

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) onDatePicked(pickedDate);
  }

  Future<void> _showCalorieFilter(BuildContext context) async {
    final result = await showDialog<RangeValues>(
      context: context,
      builder: (context) => CalorieFilterDialog(
        initialMin: _currentMinCalories,
        initialMax: _currentMaxCalories,
        onFilterApplied: onCalorieFilter,
      ),
    );
  }

  int get _currentMinCalories =>
      (filterType == FilterType.calorieRange) ? calorieRange.start.round() : 25;

  int get _currentMaxCalories => (filterType == FilterType.calorieRange)
      ? calorieRange.end.round()
      : 10000;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.37,
      padding: EdgeInsets.only(top: 32.h, left: 8.w, right: 8.w, bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(155.r),
            bottomRight: Radius.circular(50.r)),
      ),
      child: Column(
        spacing: 12.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _showCalorieFilter(context),
                icon: Icon(
                  Icons.filter_list,
                  size: 34,
                  color: filterType == FilterType.calorieRange
                      ? Colors.amber
                      : Colors.white,
                ),
              ),
              Text(
                "MealMate",
                style: context.title.copyWith(color: Colors.white),
              ),
              IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today, color: Colors.white),
              ),
            ],
          ),
          DayFilter(
            days: days,
            filterType: filterType,
            selectedDate: selectedDate,
            onDaySelected: onDaySelected,
          ),
        ],
      ),
    );
  }
}
