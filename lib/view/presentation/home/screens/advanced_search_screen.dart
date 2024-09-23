import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/view/controllers/search_controllers/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/cities_controller/cities_cubit.dart';
import '../../../controllers/cities_controller/cities_states.dart';
import '../../../controllers/search_controllers/search_states.dart';
import '../data/project_model.dart';

class AdvancedSearchScreen extends StatefulWidget {
  @override
  _AdvancedSearchScreenState createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  late Future<List<ProjectType>> projectTypesFuture;
  ProjectType? selectedProjectType;
  ProjectType? selectedCity;

  final TextEditingController _projectNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    projectTypesFuture = SearchCubit().fetchProjectTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'خيارات البحث',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputSection(
                context: context,
                label: 'اسم المشروع',
                icon: Icons.business,
                isDropdown: false,
                controller:_projectNameController ,
              ),
              SizedBox(height: mediaQueryHeight(context) * 0.02),
              Text(
                'المدينة',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ), SizedBox(height: mediaQueryHeight(context) * 0.02),
              BlocBuilder<CitiesCubit, CitiesState>(
                builder: (context, state) {
                  if (state is CitiesLoading) {
                    return _buildLoadingShimmer();
                  } else if (state is CitiesLoaded) {
                    final cities = state.cites;
                    return SizedBox(
                      height: mediaQueryHeight(context) * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedCity?.id ==
                              cities[index]
                                  .id; // Check if this city is selected
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCity = ProjectType(
                                    id: cities[index].id,
                                    name: cities[index].name);
                              });
                              print('Selected city: ${cities[index].name}');
                              print('Selected city: ${cities[index].id}');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              child: Container(
                                width: mediaQueryWidth(context) * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey
                                          .shade300, // Change background color based on selection
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image(
                                          image: cities[index].image.isNotEmpty
                                              ? NetworkImage(
                                                  cities[index].image)
                                              : AssetImage(
                                                      'assets/images/logo-b.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      cities[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors
                                                .black, // Change text color based on selection
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
                  } else if (state is CitiesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(height: mediaQueryHeight(context) * 0.02),
              Text(
                'نوع المشروع',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ), SizedBox(height: mediaQueryHeight(context) * 0.02),
              FutureBuilder<List<ProjectType>>(
                future: projectTypesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No project types available');
                  } else {
                    return _buildProjectTypeDropdown(
                      context: context,
                      label: 'نوع المشروع',
                      icon: Icons.home,
                      dropdownItems: snapshot.data!,
                    );
                  }
                },
              ),

              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchFilteredLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchFilteredLoaded) {
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
                  } else if (state is SearchFilteredError) {
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
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                print('Search button pressed');
                print('  name:${_projectNameController.text} ');
                print('  city:${selectedCity?.id} ');
                print('  type:${selectedProjectType?.id} ');
                print('Search button pressed');

                context.read<SearchCubit>().searchFilteredProjects(
                  name: _projectNameController.text,
                  city: selectedCity!.id.toString(),  // Convert to String
                  type: selectedProjectType!.id.toString(),  // Convert to String
                );
              },

              icon: Icon(Icons.search),
              label: Text('بحث'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primary,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
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


  Widget _buildInputSection({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isDropdown,
    required TextEditingController controller,

    List<ProjectType>? dropdownItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(height: 8),
        isDropdown
            ? _buildProjectTypeDropdown(
                context: context,
                label: label,
                icon: icon,
                dropdownItems: dropdownItems!)
            : _buildTextField(context, "اسم المشروع", icon, controller),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String hint, IconData icon, TextEditingController controller) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
      controller:   controller,
      decoration: InputDecoration(
        hintText: hint,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.dark,
            ),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }

  Widget _buildProjectTypeDropdown({
    required BuildContext context,
    required String label,
    required IconData icon,
    required List<ProjectType> dropdownItems,
  }) {
    return DropdownButtonFormField<ProjectType>(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      value: selectedProjectType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      items: _buildDropdownMenuItems(dropdownItems),
      onChanged: (ProjectType? value) {
        setState(() {
          selectedProjectType = value;
        });
        if (value != null) {
          print('Selected project type: ${value.name}, ID: ${value.id}');
        }
      },
      hint: Text('اختر من القائمة'),
    );
  }

  Widget _buildCityDropdown({
    required BuildContext context,
    required String label,
    required IconData icon,
    required List<ProjectType> dropdownItems,
  }) {
    return DropdownButtonFormField<ProjectType>(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
      value: selectedCity,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      items: _buildDropdownMenuItems(dropdownItems),
      onChanged: (ProjectType? value) {
        setState(() {
          selectedCity = value;
        });
        if (value != null) {
          print('Selected city: ${value.name}, ID: ${value.id}');
        }
      },
      hint: Text('اختر من القائمة'),
    );
  }

  // Builds unique dropdown items from the provided list
  List<DropdownMenuItem<ProjectType>> _buildDropdownMenuItems(
      List<ProjectType> items) {
    // Ensure uniqueness by converting the list to a set
    final uniqueItems = items.toSet().toList();
    return uniqueItems.map((item) {
      return DropdownMenuItem<ProjectType>(
        value: item,
        child: Text(item.name),
      );
    }).toList();
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
