import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';

import '../../../../shared/global/app_colors.dart';

class NewProjects extends StatelessWidget {
  const NewProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المشروعات الجديدة',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to another screen for "View All"
                },
                child: Text(
                  'اظهار الكل',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mediaQueryHeight(context) * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: mediaQueryHeight(context) * 0.15,
                  width: mediaQueryWidth(context) * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: const Image(
                        image: AssetImage(
                          'assets/images/logo.jpg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}