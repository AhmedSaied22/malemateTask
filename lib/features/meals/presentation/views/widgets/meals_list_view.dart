import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/features/meals/presentation/views/widgets/meal_item.dart';
import 'package:mealmate/features/meals/presentation/manager/cubit/meal_cubit.dart';

class MealsListView extends StatelessWidget {
  const MealsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(builder: (context, state) {
      if (state is MealsLoaded || state is MealAddedSuccess) {
        final meals = state is MealsLoaded ? state.meals : (state as MealAddedSuccess).meals;
        return ListView.builder(
          itemCount: meals.length,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          itemBuilder: (context, index) {
            return MealItem(
              mealModel: meals[index],
            );
          },
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