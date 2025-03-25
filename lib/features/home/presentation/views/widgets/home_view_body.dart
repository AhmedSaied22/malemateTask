import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/utils/calorie_calculator.dart';
import 'package:mealmate/core/utils/enums.dart';
import 'package:mealmate/features/home/presentation/views/widgets/calories_circle.dart';
import 'package:mealmate/features/home/presentation/views/widgets/home_container.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/presentation/views/widgets/meals_list_view.dart';
import 'package:mealmate/features/meals/presentation/manager/meal%20cubit/meal_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  FilterType _filterType = FilterType.all;
  DateTime? _selectedDate;
  late List<DateTime?> _days;
  RangeValues _calorieRange = const RangeValues(25, 10000);

  @override
  void initState() {
    super.initState();
    _days = _generateDays();
  }

  List<DateTime?> _generateDays() {
    final now = DateTime.now();
    return [
      null, // Represents "All"
      now,
      now.add(const Duration(days: 1)),
      now.add(const Duration(days: 2)),
      now.add(const Duration(days: 3)),
      now.add(const Duration(days: 4)),
      now.add(const Duration(days: 5)),
      now.add(const Duration(days: 6)),
    ];
  }

  void _handleDaySelection(DateTime? day) {
    setState(() {
      _filterType = day == null ? FilterType.all : FilterType.day;
      _selectedDate = day;
    });
  }

  void _handleDatePickerSelection(DateTime date) {
    setState(() {
      _filterType = FilterType.day;
      _selectedDate = date;
    });
  }

  void _handleCalorieFilter(RangeValues range) {
    setState(() {
      _filterType = FilterType.calorieRange;
      _calorieRange = range;
    });
  }

  int _calculateTotalCalories(List<Meal> meals) {
    return CalorieCalculator.calculateTotalCalories(
      meals,
      _filterType,
      _selectedDate,
      _calorieRange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        int totalCalories = 0;
        List<Meal> meals = [];

        if (state is MealsLoaded || state is MealAddedSuccess) {
          meals = state is MealsLoaded
              ? state.meals
              : (state as MealAddedSuccess).meals;
          totalCalories = _calculateTotalCalories(meals);
        }

        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                HomeViewGreenContainer(
                  days: _days,
                  filterType: _filterType,
                  selectedDate: _selectedDate,
                  onDaySelected: _handleDaySelection,
                  onDatePicked: _handleDatePickerSelection,
                  calorieRange: _calorieRange,
                  onCalorieFilter: _handleCalorieFilter,
                ),
                Positioned(
                    bottom: -context.screenHeight * 0.12,
                    left: 0,
                    right: 0,
                    child: CalorieCircle(calories: totalCalories, goal: 2000)),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.1),
            Expanded(
                child: MealsListView(
              filterType: _filterType,
              selectedDate: _selectedDate,
              calorieRange: _calorieRange,
            )),
          ],
        );
      },
    );
  }
}
