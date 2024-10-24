import 'package:enjaz/shared/utils/app_assets.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../shared/utils/app_routes.dart';
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
                  GestureDetector(
                    onTap: (){
                      navigateTo(context: context, screenRoute: Routes.profileScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape:  BoxShape.circle,
                        border: Border.all(
                            color: Color(0xFFFEAEAEA),
                            width: 1), // Border around the icon

                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.person_outline_rounded
                         ),
                      )
                    )
                  ),
                ],
              ),
            ),
          //  BannerWithImages(),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
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
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color(0xFFFEAEAEA),
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
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color(0xFFFEAEAEA),
                              width: 1), // Border around the text field
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "البحث عن مشروع، منطقة، مطور",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            CircleStories(),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            NewAllProjects(
              onTap:  () {
                widget.goAllProjects!();
              },
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            const PopularAreas(),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            Recommended(
              onTap:  () {
                widget.goAllProjects!();
              },
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.02),

          ],
        ),
      )
    );
  }
}


