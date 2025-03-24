import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/features/home/presentation/views/widgets/calories_circle.dart';
import 'package:mealmate/features/home/presentation/views/widgets/home_container.dart';
import 'package:mealmate/features/meals/presentation/views/widgets/meals_list_view.dart';
import 'package:mealmate/features/meals/presentation/manager/cubit/meal_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<MealCubit>().getMeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        return Column(
          spacing: 16.h,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HomeViewGreenContainer(),
                Positioned(
                    bottom: -context.screenHeight * 0.12,
                    left: 0,
                    right: 0,
                    child: const CalorieCircle(calories: 1122, goal: 2000)),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.08),
            const Expanded(child: MealsListView()),
          ],
        );
      },
    );
  }
}
