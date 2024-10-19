import 'package:enjaz/shared/utils/navigation.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../screens/search_screen.dart';

class appbar extends StatelessWidget {
  final String title;

  const appbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: mediaQueryHeight(context) * 0.045),
      Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
            },
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 14
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xFFFEAEAEA),
                  width: .5
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Navigate to search screen
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                isBackButton: true,
                              )));
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
