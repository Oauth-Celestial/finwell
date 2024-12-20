import 'package:finwell/feature/auth/presentation/login_page.dart';
import 'package:finwell/feature/auth/presentation/user_creation_success.dart';
import 'package:finwell/feature/dashboard/presentation/dashboard.dart';
import 'package:finwell/feature/dashboard/presentation/pages/no_spend_mode.dart';
import 'package:finwell/feature/onboarding/presentation/name_page.dart';
import 'package:finwell/feature/onboarding/presentation/pre_login_onboarding/pre_login_onboard.dart';
import 'package:finwell/feature/pending_transactions/presentation/catch_up_page.dart';
import 'package:finwell/feature/pending_transactions/presentation/pending_page.dart';
import 'package:finwell/feature/splash_screen/presentation/splash_screen.dart';
import 'package:finwell/feature/transaction/presentation/add_transaction.dart';
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
      case routeDashboardScreen:
        return MaterialPageRoute(
            builder: (_) => const DashboardPage(), settings: settings);
      case preLoginOnboardScreen:
        return MaterialPageRoute(
            builder: (_) => const PreLoginOnboardingScreen(),
            settings: settings);
      case routeUserSuccess:
        return MaterialPageRoute(
            builder: (_) => const UserCreationSuccess(), settings: settings);
      case routeAddTransaction:
        return MaterialPageRoute(
            builder: (_) => const AddTransaction(), settings: settings);

      case routePendingTransaction:
        return MaterialPageRoute(
            builder: (_) => const PendingTransactionPage(), settings: settings);
      case routeCatchUpPage:
        return MaterialPageRoute(
            builder: (_) => const CatchUpStartPage(), settings: settings);

      case routeNoSpendMode:
        return MaterialPageRoute(
            builder: (_) => const NoSpendMode(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
