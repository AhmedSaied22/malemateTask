import 'package:flutter/material.dart';
import 'package:mealmate/features/meals/presentation/views/widgets/add_meal_form.dart';

class AddMealView extends StatelessWidget {
  const AddMealView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Meal')),
      body: const AddMealForm(),
    );
  }
}
