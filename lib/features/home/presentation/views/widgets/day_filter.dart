import 'package:flutter/material.dart';
import 'package:mealmate/core/utils/enums.dart';
import 'package:mealmate/features/home/presentation/views/widgets/day_item.dart';

class DayFilter extends StatelessWidget {
  final List<DateTime?> days;
  final FilterType filterType;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDaySelected;

  const DayFilter({
    super.key,
    required this.days,
    required this.filterType,
    required this.selectedDate,
    required this.onDaySelected,
  });

  bool _isSelected(DateTime? day) {
    if (day == null) return filterType == FilterType.all;
    return filterType == FilterType.day &&
        selectedDate != null &&
        day.isAtSameMomentAs(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: days.map((day) {
            return DayItem(
              day: day,
              isSelected: _isSelected(day),
              onTap: () => onDaySelected(day),
            );
          }).toList(),
        ),
      ),
    );
  }
}
