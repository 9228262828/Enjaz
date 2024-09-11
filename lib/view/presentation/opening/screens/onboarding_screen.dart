import 'package:flutter/material.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
          navigateTo(context: context, screenRoute: Routes.homeScreen);
          },
          child: Text('go_to_home'),
        )
      ),
    );
  }
}
