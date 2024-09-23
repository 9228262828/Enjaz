import 'package:enjaz/view/presentation/home/componants/speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'المشروعات المميزة',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: mediaQueryHeight(context) * 0.42,
          child:  BlocBuilder<AllProjectsFeaturedCubit, AllProjectsFeaturedState>(
            builder: (context, state) {
              if (state is AllProjectsFeaturedLoading) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: SizedBox(
                    height: mediaQueryHeight(context) * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      padding: EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Container(
                            height: mediaQueryHeight(context) * 0.15,
                            width: mediaQueryWidth(context) * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[300],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (state is AllProjectsFeaturedLoaded) {
                return SizedBox(
                  height: mediaQueryHeight(context) * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      final project = state.projects[index];
                      return GestureDetector(
                        onTap: () {
                          navigateTo(
                            context: context,
                            screenRoute: Routes.projectDetailsScreen,
                            arguments: project,
                          );
                        },
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: Image.network(
                                        project.image as String,
                                        height: mediaQueryHeight(context) * 0.22,
                                        width: double .infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
/*
                                    if (project.sections?.developer != null && project.sections!.developer!.image != false)
*/
                                   /* Positioned(
                                        bottom: 8,
                                        left: 8,
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
                                            backgroundImage:  Image(
                                              image: NetworkImage(
                                                project.sections!.developer!.image as String,
                                              ),
                                              fit: BoxFit.contain,
                                              alignment:  Alignment.center,
                                            ).image,
                                            // Logo image
                                            radius: 20,
                                          ),
                                        )
                                    ),*/
                                  ],
                                ),

                                // Property Info section
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                       project.title as String,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: mediaQueryHeight(context) * 0.01),
                                      Text(
                                        project.location![0] as String,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                ),

                                // Pricing info section
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
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
                    },
                  ),
                );
              } else {

                return const Center(child: Text('Something went wrong.'));
              }
            },
          ),
        ),
      ],
    );
  }
}
/**/