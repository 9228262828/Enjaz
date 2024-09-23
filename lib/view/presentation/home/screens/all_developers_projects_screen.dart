import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';
import '../componants/speed_dial.dart';

class AllDevelopersProjectsScreen extends StatefulWidget {
  final int projectId;
  final int projectCount;
  final String projectTitle;
  final String projectContent;

  AllDevelopersProjectsScreen({
    required this.projectId,
    required this.projectCount,
    required this.projectTitle,
    required this.projectContent,
  });

  @override
  State<AllDevelopersProjectsScreen> createState() =>
      _AllDevelopersProjectsScreenState();
}

class _AllDevelopersProjectsScreenState
    extends State<AllDevelopersProjectsScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    context.read<ProjectCubit>().fetchProjects(
          projectId: widget.projectId,
          pageCount: widget.projectCount,
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.projectTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ProjectCubit, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoading) {
                return _buildShimmerLoading();
              } else if (state is ProjectLoaded) {
                return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<ProjectCubit>().fetchProjects(
                            projectId: widget.projectId,
                            pageCount: widget.projectCount,
                          );
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildExpandableText(),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8.0),
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.projects.length + 1,
                          // Add 1 for the shimmer loading indicator
                          itemBuilder: (context, index) {
                            if (index < state.projects.length) {
                              final project = state.projects[
                                  index]; // Use state.projects instead of projects

                              return GestureDetector(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    screenRoute: Routes.projectDetailsScreen,
                                    arguments: project,
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image section with favorite and share icons
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            project.image ?? '',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.23,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                project.title ?? 'No title',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              Text(
                                                project.location?.join(', ') ??
                                                    'N/A',
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
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                  child: SizedBox()); // Shimmer loading effect
                            }
                          },
                        ),
                      ],
                    ));
              } else if (state is ProjectError) {
                return Center(child: Text(state.message));
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
  Widget _buildExpandableText() {
    final text = widget.projectContent.toString(); // The content text

    return LayoutBuilder(
      builder: (context, constraints) {
        // Create a text painter to calculate the height of the text
        final span = TextSpan(
          text: text,
          style: Theme.of(context).textTheme.displayMedium, // Use any text style you like
        );

        final tp = TextPainter(
          text: span,
          maxLines: isExpanded ? null : 4, // Show 4 lines initially
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );

        tp.layout(maxWidth: constraints.maxWidth);


        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.displayMedium,
              maxLines: isExpanded ? null : 4,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            // Show "See More/Less" only if the text overflows
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded; // Toggle expanded/collapsed state
                  });
                },
                child: Text(
                  isExpanded ? "عرض اكثر" : "عرض اقل",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            // Padding between items
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section with favorite and share icons
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    // Custom color for image shimmer
                    highlightColor: Colors.grey[200]!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(height: mediaQueryHeight(context) * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          // Custom color for card text
                          highlightColor: Colors.grey[200]!,
                          child: Container(
                            width: 80,
                            height: 20,
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.01),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          // Custom color for card text
                          highlightColor: Colors.grey[200]!,
                          child: Container(
                            width: 40,
                            height: 20,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pricing info section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            // Custom color for card text
                            highlightColor: Colors.grey[200]!,
                            child: Container(
                              width: 120,
                              height: 20,
                              color: Colors.grey[400],
                            ),
                          ),
                          Spacer(),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            // Custom color for card text
                            highlightColor: Colors.grey[200]!,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                              ),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: mediaQueryWidth(context) * 0.02),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            // Custom color for card text
                            highlightColor: Colors.grey[200]!,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                              ),
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
