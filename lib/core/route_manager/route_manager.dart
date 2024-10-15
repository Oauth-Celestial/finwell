import 'package:finwell/feature/auth/presentation/login_page.dart';
import 'package:finwell/feature/dashboard/presentation/dashboard.dart';
import 'package:finwell/feature/onboarding/presentation/name_page.dart';
import 'package:finwell/feature/splash_screen/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

part 'app_routes.dart';

bool hasLogout = false;

// https://www.youtube.com/watch?v=C7CAMPdUu8o
class AppRouteManager {
  AppRouteManager._();

  static final AppRouteManager _manager = AppRouteManager._();
  static AppRouteManager get shared => _manager;

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplashScreen:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(), settings: settings);
      case routeLoginScreen:
        return MaterialPageRoute(
            builder: (_) => const LoginPage(), settings: settings);
      case routeNameScreen:
        return MaterialPageRoute(
            builder: (_) => const NamePage(), settings: settings);
      case routeHomeScreen:
        return MaterialPageRoute(
            builder: (_) => const HomePage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
