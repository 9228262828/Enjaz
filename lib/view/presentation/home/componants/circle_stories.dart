import 'package:enjaz/shared/utils/app_assets.dart';
import 'package:enjaz/shared/utils/navigation.dart';
import 'package:enjaz/view/controllers/developers_controllers/developers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../controllers/developers_controllers/developers_states.dart';
import '../screens/all_developers_projects_screen.dart';

class CircleStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevelopersFeaturedCubit, DevelopersFeaturedState>(
      builder: (context, state) {
        if (state is DevelopersFeaturedLoading)
        {
          return Shimmer.fromColors(
             baseColor:Colors.grey[200]!,
            highlightColor: Colors.grey.shade100,

            child: SizedBox(
              height: MediaQuery.of(context).size.height * .12,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey[50],
                    ),
                  );
                },
              ),
            ),
          );
        }
        else if (state is DevelopersFeaturedLoaded) {
          final developers = state.developers;
          return SizedBox(
            height: MediaQuery.of(context).size.height * .12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: developers.length + 1,
              itemBuilder: (context, index) {
                if (index == developers.length) {
                  return GestureDetector(
                    onTap: () {
                      navigateTo(
                          context: context,
                          screenRoute: Routes.allDevelopersScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'عرض المزيد',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                            fontWeight:   FontWeight.bold,
                              color: Color(0xFF0F659F),fontSize: 12),
                        ),
                      ),
                    ),
                  );
                }
                else if (index < developers.length) {
                  final developer = developers[index];
                  final isClickable =
                      developer.count > 0; // Define your condition here
                  return GestureDetector(
                    onTap: isClickable
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllDevelopersProjectsScreen(
                                  projectId: developer.id,
                                  projectTitle: developer.name,
                                  projectCount: developer.count,
                                        projectContent: developer.description,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[400]!, style: BorderStyle.solid, width: 3),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: developer.image.startsWith('http')
                              ? CircleAvatar(
                            backgroundColor: Colors.grey[50]!,
                                radius: 35,
                              backgroundImage: Image(
                                image: NetworkImage(
                                  developer.image,
                                ),
                              ).image,
                              )
                              : CircleAvatar(
                            radius: 35,
                            backgroundImage: Image(
                              image: AssetImage(ImageAssets.placeHolder)
                            ).image,
                          )
                        )),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          );
        } else if (state is DevelopersFeaturedError) {
          return Center(child: Text(state.message));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
