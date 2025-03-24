// 1. Enhanced Model (meal_model.dart)
import 'package:hive/hive.dart';

part 'meal_model.g.dart';

@HiveType(typeId: 0)
class Meal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int calories;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  final String imagePath;

  Meal({
    required this.id,
    required this.name,
    required this.calories,
    required this.time,
    required this.imagePath,
  });
}
