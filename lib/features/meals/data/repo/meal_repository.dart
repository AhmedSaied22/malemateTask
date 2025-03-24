import 'package:mealmate/features/meals/data/model/meal_model.dart';

abstract class MealRepository {
  Future<void> addMeal(Meal meal);
  Future<void> deleteMeal(String id);
  List<Meal> getAllMeals();
}
