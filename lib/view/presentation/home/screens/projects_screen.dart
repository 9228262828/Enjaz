import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../componants/popular_areas.dart';
import '../componants/speed_dial.dart';

class Project {
  final String developer;
  final String title;
  final String description;
  final String location;
  final String imagePath;
  final String? price;

  Project({
    required this.developer,
    required this.title,
    required this.description,
    required this.location,
    required this.imagePath,
    this.price,
  });
}

class ProjectsScreen extends StatelessWidget {
  final Function()? goSearch;
   ProjectsScreen({super.key, this.goSearch});
  final List<Project> projects = [
    Project(
      developer: 'Bloomfields',
      title: 'COFLOW',
      description: 'كوفلو في بلوم فيلدز من تطوير مصر',
      location: 'مدينة المستقبل، مصر',
      imagePath: 'assets/images/logo.jpg', // Example asset image
    ),
    Project(
      developer: 'Hasan Allam Properties',
      title: 'KEYS 52',
      description: 'كنز 52 من حسن علام العقارات',
      location: 'القاهرة الجديدة، مصر',
      imagePath: 'assets/images/logo.jpg',
    ),
    Project(
      developer: 'LaVista',
      title: 'EL PATIO',
      description: 'الباتيو الشروق من لافيستا',
      location: 'الشروق، مصر',
      imagePath: 'assets/images/logo.jpg',
    ),
    Project(
      developer: 'Hyde Park',
      title: 'Jardin Lakes',
      description: 'جاردن ليكس - من ماجد بارك',
      location: 'مجتمع السكني في كايرو مصر',
      imagePath: 'assets/images/logo.jpg',
      price: '19,000,000 ج.م',
    ),
    Project(
      developer: 'EgyGab',
      title: 'The ISLANDS',
      description: 'دا ايلاندر من ايجي جاب',
      location: 'العاصمة الادارية الجديدة، مصر',
      imagePath: 'assets/images/logo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  ImageAssets.logo,
                  height: 50,
                ),
                GestureDetector(
                  onTap:  goSearch,
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
          SizedBox(height: mediaQueryHeight(context) * 0.02),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: projects.length + 3,
              // Add 2: one for the static text, one for the button
              itemBuilder: (context, index) {
                if (index == 0) {
                  // This will display the static text at the top
                  return  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "احدث ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColors.dark,fontWeight: FontWeight.w100),
                            ),
                            Text(
                              "المشاريع",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.01),
                        Text(
                          "اطلاقات قريبة",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColors.dark),
                        ),
                        Text(
                          "مشاريع جديدة متوفرة الان",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.boldGrey,fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  );
                } else if (index == projects.length + 1) {
                  // This will display the "Load More" button at the end of the list
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Load More" action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(mediaQueryWidth(context) * 0.9, 60),
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        child: Text(
                          'عرض المزيد',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.01),
                    ],
                  );
                } else if (index == projects.length + 2) {
                  // This will display the "Load More" button at the end of the list
                  return PopularAreas();
                }
                // This will display the project cards for the remaining items
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildProjectCard(context, projects[
                      index - 1]), // Adjust index to match projects list
                );
              },
            ),
          ),
        //  _buildFooter(),
        ],
      ),
      floatingActionButton: SpeedDial(
        activeIcon: Icons.close,
        icon: FontAwesomeIcons.headset,
        activeBackgroundColor: Colors.red.withOpacity(.5),
        foregroundColor: Colors.white,
        buttonSize: Size(50.0, 50.0),
        backgroundColor:  AppColors.primary,
        animatedIconTheme: IconThemeData(size: 22.0),
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          buildphone(context),
          buildWhatsapp(context),
        ],
      ),
    );
  }

  Widget _buildProjectCard(context,Project project) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(project.imagePath, height: 150, fit: BoxFit.contain),
          SizedBox(height: mediaQueryHeight(context) * 0.01),
          Text(
            project.description,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.01),
          Text(
            project.location,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          if (project.price != null && project.price!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'السعر الابتدائي: ${project.price}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }


}
