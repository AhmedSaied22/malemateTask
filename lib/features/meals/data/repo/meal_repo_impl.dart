import 'package:hive/hive.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/data/repo/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final Box<Meal> _mealBox;

  MealRepositoryImpl(this._mealBox);

  @override
  Future<void> addMeal(Meal meal) async => await _mealBox.put(meal.id, meal);

  @override
  Future<void> deleteMeal(String id) async => await _mealBox.delete(id);

  @override
  List<Meal> getAllMeals() => _mealBox.values.toList();
}
