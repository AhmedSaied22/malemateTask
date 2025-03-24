import 'package:flutter/material.dart';
import 'package:mealmate/core/routes/routes_name.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'add meal',
          tooltip: "Add MEAL",
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.addMeal);
          },
          child: const Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: const HomeViewBody());
  }
}
