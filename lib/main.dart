import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mealmate/app.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());

  await Hive.openBox<Meal>('meals');

  initializeDateFormatting('en').then((_) {
    runApp(const MyApp());
  });
}
