import 'package:flutter/material.dart';
import 'package:mealmate/core/utils/enums.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';

class CalorieCalculator {
  static int calculateTotalCalories(
    List<Meal> meals,
    FilterType filterType,
    DateTime? selectedDate,
    RangeValues calorieRange,
  ) {
    final filtered = meals.where((meal) {
      final inCalorieRange = meal.calories >= calorieRange.start &&
          meal.calories <= calorieRange.end;

      if (filterType == FilterType.all) return inCalorieRange;
      if (filterType == FilterType.day) {
        return _isSameDay(meal.time, selectedDate!) && inCalorieRange;
      }
      return inCalorieRange;
    });

    return filtered.fold(0, (sum, meal) => sum + meal.calories);
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
