part of 'meal_cubit.dart';

sealed class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

final class MealInitial extends MealState {}

final class MealLoading extends MealState {}

class MealAddedSuccess extends MealState {
  final List<Meal> meals;

  const MealAddedSuccess(this.meals);

  @override
  List<Object> get props => [meals];
}

final class MealDeletedSuccess extends MealState {}

final class MealsLoaded extends MealState {
  final List<Meal> meals;

  const MealsLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

final class MealError extends MealState {
  final String message;
  const MealError(this.message);
}
