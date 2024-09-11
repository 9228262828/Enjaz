import 'package:flutter/material.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_values.dart';
import '../screens/home_screen.dart';

class CircleStories extends StatelessWidget {
  CircleStories({super.key});

  final List<String> logos = [
    'assets/images/logo.jpg',
    'assets/images/logo.jpg',
    'assets/images/logo.jpg',
    'assets/images/logo.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaQueryHeight(context) * .12,
      // Adjust height based on your logo sizes
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: logos.length + 1, // Adding one for "Show All" button
        itemBuilder: (context, index) {
          if (index == logos.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllItemsScreen(logos: logos)),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                 // width: 80, // Adjust width for "Show All" box
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('اظهار الكل', style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.primary),),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey.shade100, style: BorderStyle.solid, width: 5),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                // Background color of the logo area
                backgroundImage: Image(
                  image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMKzIa3SQs1ortmJ0s_XCiDDlnOLYeMpq7lg&s",
                  ),
                  fit: BoxFit.contain,
                  alignment:  Alignment.center,
                ).image,
                // Logo image
                radius: 35,
              ),
            ),
          );
        },
      ),
    );
  }
}
