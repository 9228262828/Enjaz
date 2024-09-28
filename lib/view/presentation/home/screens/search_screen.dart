import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_theme.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';
import '../../../controllers/search_controllers/search_cubit.dart';
import '../../../controllers/search_controllers/search_states.dart';
import '../data/project_model.dart';

class SearchScreen extends StatelessWidget {
  final bool isBackButton;

  final TextEditingController _searchController = TextEditingController();

   SearchScreen({super.key, required this.isBackButton});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mediaQueryHeight(context) * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    isBackButton ?
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ): const SizedBox(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: TextField(
                          controller: _searchController,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary),
                          decoration: customInputDecoration(
                            context,
                            'البحث عن منطقة، المطور, المشروع',
                            '',
                          ),
                          onSubmitted: (query) {
                            if (query.isNotEmpty) {
                              context.read<SearchCubit>().searchProjects(query);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: mediaQueryWidth(context) * 0.02),
                    GestureDetector(
                      onTap: () {
                        navigateTo(
                          context: context,
                          screenRoute: Routes.advancedSearchScreen,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaQueryHeight(context) * 0.01),
            ],
          ),
        ),
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: _buildShimmerEffect(context));
                  } else if (state is SearchLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "نتائج البحث",
                            style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                        _buildSearchResults(state.projects, context),
                      ],
                    );
                  } else if (state is SearchError) {
                    return Center(
                        child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.boldGrey
                      ),
                    ));
                  } else {
                    return Container();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "عمليات البحث الرائجة",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              MyGridView(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "عمليات البحث السابقة",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              FutureBuilder<List<String>>(
                future: context.read<SearchCubit>().getLastSearches(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final lastSearches = snapshot.data!;
                    return Column(
                      children: lastSearches.map((search) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<SearchCubit>()
                                      .searchProjects(search);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(search),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.search),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                indent: 8,
                                endIndent: 8,
                                color: Colors.grey[300],
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Project> projects, context) {
    return SizedBox(
      height: mediaQueryHeight(context) * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return GestureDetector(
            onTap: () {
              navigateTo(
                context: context,
                screenRoute: Routes.projectDetailsScreen,
                arguments: project,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
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
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        project.image as String,
                        height: mediaQueryHeight(context) * 0.12,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        project.title as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Property Info section
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "نتائج البحث",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                ),
          ),
        ),
        SizedBox(height: mediaQueryHeight(context) * 0.01),
        SizedBox(
          height: mediaQueryHeight(context) * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Adjust the number of shimmer items as needed
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: mediaQueryHeight(context) * 0.12,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20, // Adjust the height as needed
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProjectsFeaturedCubit, AllProjectsFeaturedState>(
      builder: (context, state) {
        if (state is AllProjectsFeaturedLoading) {
          return Center(child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 2.0,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.2,
              ),
              itemCount: 5, // Show 5 shimmer placeholders
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              },
            ),
          ));
        } else if (state is AllProjectsFeaturedLoaded) {
          final projects = state.projects;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.2, // Adjust height as needed
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // Number of items per row
                      mainAxisSpacing: 8.0,
                      // Vertical spacing between items
                      crossAxisSpacing: 5.0,
                      // Horizontal spacing between items
                      childAspectRatio: 2.0,
                      // Aspect ratio of each item
                      mainAxisExtent: MediaQuery.of(context).size.height * 0.2,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateTo(
                            context: context,
                            screenRoute: Routes.projectDetailsScreen,
                            arguments: projects[index],
                          );
                        },
                        child: SearchChip(
                          label:
                              projects[index].title ?? '', // Show project name
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is AllProjectsFeaturedError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container();
        }
      },
    );
  }
}

class SearchChip extends StatelessWidget {
  final String label;

  const SearchChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.house_siding,
            color: Colors.blue,
            size: 15,
          ),
          SizedBox(width: mediaQueryWidth(context) * 0.01),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
