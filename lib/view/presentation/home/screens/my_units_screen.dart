import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_values.dart';

class Region {
  final String name;
  final String image;
  final int projects;
  final int units;

  Region({
    required this.name,
    required this.image,
    required this.projects,
    required this.units,
  });
}

class MyUnitsScreen extends StatelessWidget {
  final Function()? goSearch;

  MyUnitsScreen({super.key, this.goSearch});

  final List<Region> regions = [
    Region(
        name: 'مدينة السادس من أكتوبر',
        image: 'assets/images/logo.jpg',        projects: 106,
        units: 1190),
    Region(
        name: 'القاهرة الجديدة',
        image: 'assets/images/logo.jpg',        projects: 183,
        units: 2029),
    Region(
        name: 'مدينة المستقبل',
        image: 'assets/images/logo.jpg',        projects: 30,
        units: 645),
    Region(
        name: 'العاصمة الإدارية الجديدة',
        image: 'assets/images/logo.jpg',
        projects: 119,
        units: 3613),
    Region(
        name: 'العين السخنة',
        image: 'assets/images/logo.jpg',        projects: 48,
        units: 458),
    // Add more regions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  ImageAssets.logo,
                  height: 50,
                ),
                GestureDetector(
                  onTap: goSearch,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: AppColors.dark, width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: regions.length ,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 16.0, // Spacing between columns
                  mainAxisSpacing: 16.0, // Spacing between rows
                  childAspectRatio: 3 / 4.5, // Aspect ratio for the grid items
                ),
                itemBuilder: (context, index) {
                  return _buildRegionCard(regions[index],context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each card
  Widget _buildRegionCard(Region region,context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8.0),
          ClipRRect(

            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              region.image,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  region.name,
                  textAlign: TextAlign.center,
                  style:Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${region.projects} مشاريع\n${region.units} وحدات',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
