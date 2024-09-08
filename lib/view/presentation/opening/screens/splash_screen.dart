import 'dart:async';
import 'package:flutter/material.dart';
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
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .6, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
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
      Timer(const Duration(seconds: 5), () {
        navigateFinalTo(context: context, screenRoute: Routes.onboardingScreen);
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        if (FirebaseAuth.instance.currentUser != null) {
          // User is logged in
          navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
        } else {
          // User is not logged in
          navigateFinalTo(context: context, screenRoute: Routes.loginScreen);
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(ImageAssets.logo),
        ),
      ),
    );
  }
}
