import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/utils/enums.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/presentation/views/widgets/meal_item.dart';
import 'package:mealmate/features/meals/presentation/manager/meal%20cubit/meal_cubit.dart';

class MealsListView extends StatelessWidget {
  final FilterType filterType;
  final DateTime? selectedDate;
  final RangeValues calorieRange;

  const MealsListView({
    super.key,
    required this.filterType,
    required this.selectedDate,
    this.calorieRange = const RangeValues(25, 10000),
  });

  List<Meal> _filterMeals(List<Meal> meals) {
    return meals.where((meal) {
      final calorieFilter = meal.calories >= calorieRange.start &&
          meal.calories <= calorieRange.end;

      if (filterType == FilterType.calorieRange) return calorieFilter;

      if (filterType == FilterType.day && selectedDate != null) {
        return _isSameDay(meal.time, selectedDate!) && calorieFilter;
      }

      return calorieFilter;
    }).toList();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(builder: (context, state) {
      if (state is MealsLoaded || state is MealAddedSuccess) {
        final meals = state is MealsLoaded
            ? state.meals
            : (state as MealAddedSuccess).meals;
        final filteredMeals = _filterMeals(meals);

        return ListView.builder(
          itemCount: filteredMeals.length,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          itemBuilder: (context, index) =>
              MealItem(mealModel: filteredMeals[index]),
        );
      } else if (state is MealError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is MealLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const Center(
          child: Text('No Meals'),
        );
      }
    });
  }
}
