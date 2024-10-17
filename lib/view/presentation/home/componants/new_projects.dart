import 'package:enjaz/shared/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';

class NewAllProjects extends StatelessWidget {
  final Function()? onTap;

  const NewAllProjects({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8,bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "المشروعات المميزة",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  onTap?.call();
                },
                child: Text(
                  'عرض المزيد',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight:   FontWeight.bold,color:  Color(0xFF0F659F),fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<AllProjectsFeaturedCubit, AllProjectsFeaturedState>(
          builder: (context, state) {
            if (state is AllProjectsFeaturedLoading) {
              return Shimmer.fromColors(
                baseColor:Color(0xFF3F8FC),
                    highlightColor:Colors.grey[300]!,
                child: SizedBox(
                  height: mediaQueryHeight(context) * 0.22,
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
                          width: mediaQueryWidth(context) * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is AllProjectsFeaturedLoaded) {
              print("projects: ${state.projects.length}");
              if (state.projects.length == 0) {
                print("projects: ${state.projects.length}");
                return  Center(child: Text(" لا يوجد مشروعات مميزة الان"),);
              }
              return SizedBox(
                height: mediaQueryHeight(context) * 0.27,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                        child: Container(
                          height: mediaQueryHeight(context) * 0.22,
                          width: mediaQueryWidth(context) * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[300],
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: project.image != null &&
                                              project.image!.isNotEmpty
                                          ? Image.network(
                                              project.image!,
                                              height: mediaQueryHeight(context) *
                                                  0.16,
                                              width: mediaQueryWidth(context) ,
                                              fit: BoxFit.fill,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                // Fallback image if network image fails
                                                return Image.asset(
                                                  ImageAssets.logo,
                                                  // Path to your local placeholder image
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              ImageAssets.logo,
                                              // Path to your local placeholder image
                                              fit: BoxFit.fill,
                                            )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:4,horizontal: 16),
                                child: Text(project.title as String,
                                    maxLines: 2,

                                    overflow:   TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      color: Color(0xFF0F0F0F),
                                      fontSize: 15
                                    )),
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
              // Fallback widget in case of unexpected state
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ],
    );
  }
}
