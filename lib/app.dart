import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/routes/routes_gen.dart';
import 'package:mealmate/core/routes/routes_name.dart';
import 'package:mealmate/core/theme/theme.dart';

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
        builder: (_, child) {
          return MaterialApp(
            title: 'MealMate',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home: Container(),
            initialRoute: RoutesName.splash,
            navigatorKey: navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
