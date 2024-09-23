import 'package:enjaz/shared/utils/app_assets.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/global/app_colors.dart';
import '../componants/banner.dart';
import '../componants/circle_stories.dart';
import '../componants/new_projects.dart';
import '../componants/popular_areas.dart';
import '../componants/recommended.dart';

class HomeScreen extends StatefulWidget {
  final Function()? goSearch;
  final Function()? goAllProjects;

  const HomeScreen({super.key, this.goSearch, this.goAllProjects});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Change this to your desired color
      statusBarIconBrightness:
      Brightness.light, // Set text/icon color for status bar
    ));
  }
    @override
    void dispose() {
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImageAssets.logo,
                    height: 35
                  ),
                 /* const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),*/
                ],
              ),
            ),
            BannerWithImages(),
            GestureDetector(
              onTap: () {
                widget.goSearch!();
                // Navigate to search screen
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    // The Icon button on the left side
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.grey,
                            width: 1), // Border around the icon
                      ),
                      padding: EdgeInsets.all(8.0),
                      // Padding inside the icon container
                      child: const Icon(
                        Icons.tune, // Replace with the appropriate icon
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: mediaQueryWidth(context) * 0.02),
                    // Add some space between the icon and the text field
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey,
                              width: 1), // Border around the text field
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            "البحث بالمنطقة، الكمبوند، المطور",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CircleStories(),
            NewAllProjects(
              onTap:  () {
                widget.goAllProjects!();
              },
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            PopularAreas(),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            Recommended(),
            SizedBox(height: mediaQueryHeight(context) * 0.02),

          ],
        ),
      )
    );
  }
}


