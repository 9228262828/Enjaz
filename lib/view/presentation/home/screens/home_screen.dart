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

  const HomeScreen({super.key, this.goSearch});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  Color _appBarBackgroundColor = Colors.white; // Default color

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Change this to your desired color
      statusBarIconBrightness:
          Brightness.light, // Set text/icon color for status bar
    ));

    _scrollController = ScrollController()
      ..addListener(() {
        // Update background color based on scroll position
        if (_scrollController.hasClients) {
          final offset = _scrollController.offset;
          if (offset > 100) {
            // You can adjust this value
            setState(() {
              _appBarBackgroundColor =
                  AppColors.backgroundGrey; // Color when pinned
            });
          } else {
            setState(() {
              _appBarBackgroundColor = Colors.white; // Default color
            });
          }
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.logo,
                        height: 50,
                      ),
                      const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                BannerWithImages(),
              ],
            ),
          ),
          SliverAppBar(
            collapsedHeight: mediaQueryHeight(context) * 0.08,
            expandedHeight: mediaQueryHeight(context) * 0.01,
            pinned: true,
            backgroundColor: _appBarBackgroundColor,
            // Dynamic color
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            title: GestureDetector(
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
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CircleStories(),
                NewProjects(),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                PopularAreas(),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                Image(image: AssetImage("assets/images/contact_us.jpg")),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                Recommended(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AllItemsScreen extends StatelessWidget {
  final List<String> logos;

  const AllItemsScreen({Key? key, required this.logos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Logos'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: logos.length,
        itemBuilder: (context, index) {
          return CircleAvatar(
            backgroundImage: AssetImage(logos[index]),
            radius: 60, // Adjust size for grid view
          );
        },
      ),
    );
  }
}
