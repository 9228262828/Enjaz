import 'package:enjaz/view/presentation/auth/screens/login_screen.dart';
import 'package:enjaz/view/presentation/home/screens/advanced_search_screen.dart';
import 'package:enjaz/view/presentation/home/screens/all_cities_screen.dart';
import 'package:flutter/material.dart';

import '../../view/presentation/auth/screens/register_screen.dart';
import '../../view/presentation/home/componants/form_add_to_sheet.dart';
import '../../view/presentation/home/screens/about_us_screen.dart';
import '../../view/presentation/home/screens/all_developers_screen.dart';
import '../../view/presentation/home/screens/all_projects_screen.dart';
import '../../view/presentation/home/screens/conatct_us_screen.dart';
import '../../view/presentation/home/screens/main_screen.dart';
import '../../view/presentation/home/screens/privacy_screen.dart';
import '../../view/presentation/home/screens/profile_screen.dart';
import '../../view/presentation/home/screens/project_details_screen.dart';
import '../../view/presentation/home/screens/terms_and_conditions.dart';
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
  static const String allDevelopersScreen = '/allDevelopersScreen';
  static const String projectDetailsScreen = '/projectDetailsScreen';
  static const String allCities = '/allCities';
  static const String contactUsScreen = '/contactUsScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String termsAndConditionsScreen = '/termsAndConditionsScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String profileScreen = '/profileScreen';
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

      case Routes.allDevelopersScreen:
        return MaterialPageRoute(
          builder: (_) => AllDevelopersScreen(),
        );

      case Routes.allCities:
        return MaterialPageRoute(
          builder: (_) => const AllCitiesScreen(),
        );

      case Routes.contactUsScreen:
        return MaterialPageRoute(
          builder: (_) =>  FormScreen(),
        );

      case Routes.advancedSearchScreen:
        return MaterialPageRoute(
          builder: (_) =>  AdvancedSearchScreen(),
        );

        case Routes.projectDetailsScreen:
        return MaterialPageRoute(
          builder: (_) =>  ProjectDetailScreen(),
          settings: routeSettings,
        );

        case Routes.privacyPolicyScreen:
        return MaterialPageRoute(
          builder: (_) =>  PrivacyPolicyScreen(),
          settings: routeSettings,
        );

        case Routes.termsAndConditionsScreen:
        return MaterialPageRoute(
          builder: (_) =>  TermsAndConditionsScreen(),
          settings: routeSettings,
        );
        case Routes.aboutUsScreen:
        return MaterialPageRoute(
          builder: (_) =>  AboutUsScreen(),
          settings: routeSettings,
        );

        case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) =>  ProfileScreen(),
          settings: routeSettings,
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
