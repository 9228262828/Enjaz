import 'package:enjaz/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';
import '../componants/speed_dial.dart';
import '../data/project_model.dart';

class ProjectsScreen extends StatefulWidget {
  final Function()? goSearch;
  final Function()? goallProjects;

  ProjectsScreen({super.key, this.goSearch, this.goallProjects});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AllProjectCubit>().fetchProjects();
  }

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
                Image.asset(
                  ImageAssets.logo,
                  height: 35,
                ),
                GestureDetector(
                  onTap: widget.goSearch,
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
          BlocBuilder<AllProjectCubit, AllProjectState>(
            builder: (context, state) {
              if (state is AllProjectLoading && state.page == 1) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 4, // Show 2 shimmer placeholders
                    itemBuilder: (context, index) {
                      return _buildShimmerCard();
                    },
                  ),
                );
              } else if (state is AllProjectLoaded) {
                final projects = state.projects;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    itemCount: projects.length + 1,
                    // +1 for the "Load More" button
                    itemBuilder: (context, index) {
                      if (index == projects.length) {
                        // "Load More" button at the end
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<AllProjectCubit>()
                                    .loadMoreProjects();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize:
                                Size(mediaQueryWidth(context) * 0.9, 60),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Text(
                                'عرض المزيد',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: mediaQueryHeight(context) * 0.01),
                          ],
                        );
                      }
                      // This handles the normal project cards
                      final project = projects[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  screenRoute: Routes.projectDetailsScreen,
                                  arguments: project,
                                );
                              },
                              child: _buildProjectCard(context, projects[index])),);
                    },
                  ),
                );
              } else if (state is AllProjectError) {
                return const Text('حدث خطأ ما');
              } else {
                return const Text('لا يوجد مشاريع');
              }
            },
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        activeIcon: Icons.close,
        icon: FontAwesomeIcons.headset,
        activeBackgroundColor: Colors.red.withOpacity(.5),
        foregroundColor: Colors.white,
        buttonSize: Size(50.0, 50.0),
        backgroundColor: AppColors.primary,
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

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[300],
              height: 150,
              width: double.infinity,
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.grey[300],
              height: 20,
              width: double.infinity,
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.grey[300],
              height: 20,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildProjectCard(BuildContext context, Project project) {
    final imageUrl = project.image ?? '';

    // Safely access the first element of the location list or provide a default value
    final location = (project.location?.isNotEmpty == true)
        ? project.location![0]
        : 'No location available';

    // Safely access the first element of the price list or provide a default value
    final price = (project.price?.isNotEmpty == true)
        ? project.price![0]
        : 'Price not available';

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with favorite and share icons
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.boldGrey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImageAssets.logo, // Use a local placeholder image
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  );
                },
              )
                  : Image.asset(
                ImageAssets.logo, // Use a local placeholder image
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title ?? 'No title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Pricing info section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  project.price![0] + ' ج.م',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    openWhatsApp();

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    print('jsdlkczxnm  ');
                  },
                  child: CircleAvatar(
                    child:ClipRRect(
                      borderRadius:   BorderRadius.circular(20),
                      child: Image.asset(
                          ImageAssets.zoom
                      ),
                    )
                  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    makePhoneCall();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.phone,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}