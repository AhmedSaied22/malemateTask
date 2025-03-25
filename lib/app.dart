import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:mealmate/core/routes/routes_gen.dart';
import 'package:mealmate/core/routes/routes_name.dart';
import 'package:mealmate/core/theme/theme.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/data/repo/meal_repo_impl.dart';
import 'package:mealmate/features/meals/presentation/manager/meal%20cubit/meal_cubit.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => MealCubit(
                    MealRepositoryImpl(Hive.box<Meal>('meals')),
                  )..getMeals(),
                ),
              ],
              child: MaterialApp(
                title: 'MealMate',
                theme: AppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                home: Container(),
                initialRoute: RoutesName.splash,
                navigatorKey: navigatorKey,
                onGenerateRoute: RouteGenerator.generateRoute,
              ));
        });
  }
}
