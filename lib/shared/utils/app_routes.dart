import 'package:enjaz/view/presentation/auth/screens/login_screen.dart';
import 'package:enjaz/view/presentation/home/screens/advanced_search_screen.dart';
import 'package:flutter/material.dart';
import '../../view/presentation/auth/screens/register_screen.dart';
import '../../view/presentation/home/screens/home_screen.dart';
import '../../view/presentation/home/screens/main_screen.dart';
import '../../view/presentation/opening/screens/onboarding_screen.dart';
import '../../view/presentation/opening/screens/splash_screen.dart';
import 'app_strings.dart';

class Routes {
  static const String splash = '/';
  static const String homeScreen = '/homeScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String registerScreen = '/registerScreen';
  static const String loginScreen = '/loginScreen';
  static const String advancedSearchScreen = '/advancedSearchScreen';


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );

        case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>  HomePage(),
        );

        case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );

        case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) =>  LoginScreen(),
        );

        case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) =>  RegisterScreen(),
        );

        case Routes.advancedSearchScreen:
        return MaterialPageRoute(
          builder: (_) =>  AdvancedSearchScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.wrongScreen),
        ),
        body: const Center(child: Text(AppStrings.routeNotFound)),
      ),
    );
  }
}
