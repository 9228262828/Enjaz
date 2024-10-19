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
                'أشهر المناطق',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18),
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
                      .copyWith(fontWeight:   FontWeight.bold,color: Color(0xFF0F659F),fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mediaQueryHeight(context) * 0.235,
          child:
              BlocBuilder<CitiesCubit, CitiesState>(builder: (context, state) {
            if (state is CitiesLoading) {
              return Shimmer.fromColors(
                    baseColor:Color(0xFF3F8FC),
                    highlightColor:Colors.grey[300]!,
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 0),
                      child: Container(
                        width: mediaQueryWidth(context) * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade300,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    height: mediaQueryHeight(context) * 0.15,
                                    width: mediaQueryWidth(context) * 0.5,
                                    image: cities[index].image.isNotEmpty
                                        ? NetworkImage(cities[index].image)
                                        : Image.asset('assets/images/logo-b.png')
                                            as ImageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              cities[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F0F0F)),
                            ),
                            SizedBox(height: mediaQueryHeight(context) * 0.01),
                            Text(
                              cities[index].count.toString() + ' مشاريع',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Color(0xFF545454),fontSize: 13),
                            ),
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
