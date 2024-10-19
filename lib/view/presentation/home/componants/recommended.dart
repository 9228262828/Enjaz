import 'package:enjaz/view/presentation/home/componants/project_widget.dart';
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
  final Function()? onTap;
  const Recommended({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'أحدث المشروعات',
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
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
        SizedBox(
          height: mediaQueryHeight(context) * 0.42,
          child:  BlocBuilder<AllProjectCubit, AllProjectState>(
            builder: (context, state) {
              if (state is AllProjectLoading) {
                return Shimmer.fromColors(
                    baseColor:Color(0xFF3F8FC),
                    highlightColor:Colors.grey[300]!,
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
                              borderRadius: BorderRadius.circular(5),
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
                          padding: const EdgeInsets.all(4.0),
                          child: ProjectWidget(
                            image:  project.image.toString(),
                            title: project.title.toString(),
                            project:  project,
                            phone:  project.title.toString(),

                            price: project.price![0],
                            location: project.location![0],
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