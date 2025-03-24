import 'package:flutter/material.dart';
import 'package:mealmate/features/home/presentation/views/widgets/day_item.dart';

class DayFilter extends StatelessWidget {
  final List<DateTime> days;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  const DayFilter({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days.map((day) {
        final bool isSelected = day.day == selectedDay.day &&
            day.month == selectedDay.month &&
            day.year == selectedDay.year;

        return DayItem(
          day: day,
          isSelected: isSelected,
          onTap: () => onDaySelected(day),
        );
      }).toList(),
    );
  }
}
