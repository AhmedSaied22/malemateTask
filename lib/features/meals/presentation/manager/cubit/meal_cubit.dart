import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/data/repo/meal_repository.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final MealRepository repository;

  MealCubit(this.repository) : super(MealInitial());

  Future<void> addMeal(Meal meal) async {
    emit(MealLoading());
    try {
      await repository.addMeal(meal);
      final meals = repository.getAllMeals();
      emit(MealAddedSuccess(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> deleteMeal(String id) async {
    emit(MealLoading());
    try {
      await repository.deleteMeal(id);
      emit(MealDeletedSuccess());
      getMeals();
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> getMeals() async {
    emit(MealLoading());
    try {
      final meals = repository.getAllMeals();
      emit(MealsLoaded(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }
}
