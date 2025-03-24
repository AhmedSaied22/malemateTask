import 'package:flutter/material.dart';
import 'package:mealmate/app.dart';
import 'package:mealmate/core/routes/routes_name.dart';
import 'package:mealmate/features/home/presentation/views/home_view.dart';
import 'package:mealmate/features/meals/presentation/views/add_meal_view.dart';
import 'package:mealmate/features/splash/presentation/views/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.splash:
        return _buildRoute(const SplashView(), RouteTransition.fade);
      case RoutesName.home:
        return _buildRoute(const HomeView(), RouteTransition.fade);
      case RoutesName.addMeal:
        return _buildRoute(const AddMealView(), RouteTransition.fade);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _buildRoute(Widget child, RouteTransition transition) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case RouteTransition.fade:
            return FadeTransition(opacity: animation, child: child);
          case RouteTransition.slideLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case RouteTransition.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case RouteTransition.scale:
            return ScaleTransition(
              scale: animation,
              child: child,
            );
        }
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text('Route Error')),
            ));
  }
}

enum RouteTransition { fade, slideLeft, slideUp, scale }

extension NavigationExtension on Widget {
  // Context-based navigation
  Future<void> push(BuildContext context,
      [RouteTransition transition = RouteTransition.fade]) {
    return Navigator.push(
        context, RouteGenerator._buildRoute(this, transition));
  }

  void pushReplacement(BuildContext context,
      [RouteTransition transition = RouteTransition.fade]) {
    Navigator.pushReplacement(
        context, RouteGenerator._buildRoute(this, transition));
  }

  void pushAndRemoveUntil(BuildContext context,
      [RouteTransition transition = RouteTransition.fade]) {
    Navigator.pushAndRemoveUntil(
      context,
      RouteGenerator._buildRoute(this, transition),
      (route) => false,
    );
  }

  // Global context navigation
  void pushGlobal([RouteTransition transition = RouteTransition.fade]) {
    Navigator.push(
      navigatorKey.currentContext!,
      RouteGenerator._buildRoute(this, transition),
    );
  }

  void pushReplacementGlobal(
      [RouteTransition transition = RouteTransition.fade]) {
    Navigator.pushReplacement(
      navigatorKey.currentContext!,
      RouteGenerator._buildRoute(this, transition),
    );
  }

  void pushAndRemoveUntilGlobal(
      [RouteTransition transition = RouteTransition.fade]) {
    Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      RouteGenerator._buildRoute(this, transition),
      (route) => false,
    );
  }
}
