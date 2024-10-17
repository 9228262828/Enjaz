import 'dart:async';
import 'package:enjaz/shared/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );


    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();

    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Timer(const Duration(seconds: 3), () {
        navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
      });
    } else {
      Timer(const Duration(seconds: 3), ()async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
        if (FirebaseAuth.instance.currentUser != null || isLoggedIn) {
          // User is logged in
          navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
        } else {
          // User is not logged in
          navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Image.asset(
            ImageAssets.logoWhite,
          ),
        ),
      ),
    );
  }
}
