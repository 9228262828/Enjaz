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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'احدث المشروعات',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  onTap?.call(); // Use null-aware call operator
                },
                child: Text(
                  'عرض المزيد',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<AllProjectCubit, AllProjectState>(
          builder: (context, state) {
            if (state is AllProjectLoading) {
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
            } else if (state is AllProjectLoaded) {
              return SizedBox(
                height: mediaQueryHeight(context) * 0.255,
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: mediaQueryHeight(context) * 0.22,
                          width: mediaQueryWidth(context) * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text(project.title as String,

                                    overflow:   TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 14
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
