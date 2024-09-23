import 'package:enjaz/shared/utils/navigation.dart';
import 'package:enjaz/view/controllers/cities_controller/cities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../controllers/cities_controller/cities_states.dart';
import '../screens/allCities_projects_screen.dart';

class PopularAreas extends StatelessWidget {
   const PopularAreas({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'اشهر المناطق',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context: context, screenRoute: Routes.allCities);
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
        SizedBox(
          height: mediaQueryHeight(context) * 0.2,
          child:
              BlocBuilder<CitiesCubit, CitiesState>(builder: (context, state) {
            if (state is CitiesLoading) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Container(
                              width: mediaQueryWidth(context) * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
            } else if (state is CitiesLoaded) {
              final cities = state.cites;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CitiesProjectsScreen(
                            projectId: cities[index].id,
                            projectCount: cities[index].count,
                            projectTitle: cities[index].name,
                            projectContent: cities[index].description,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: mediaQueryWidth(context) * 0.4,
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
                                  color: Colors.grey.shade300,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image(
                                    height: mediaQueryHeight(context) * 0.12,
                                    image: cities[index].image.isNotEmpty
                                        ? NetworkImage(cities[index].image)
                                        : Image.asset('assets/images/logo-b.png')
                                            as ImageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Text( cities[index].name,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is CitiesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          }),
        )
      ],
    );
  }
}
