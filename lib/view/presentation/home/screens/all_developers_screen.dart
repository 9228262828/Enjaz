import 'package:enjaz/view/controllers/developers_controllers/developers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../controllers/developers_controllers/developers_states.dart';
import 'all_developers_projects_screen.dart';

class AllDevelopersScreen extends StatefulWidget {
  @override
  _AllDevelopersScreenState createState() => _AllDevelopersScreenState();
}

class _AllDevelopersScreenState extends State<AllDevelopersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<DeveloperCubit>().fetchDevelopers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<DeveloperCubit>().fetchDevelopers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'كل المطورين',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<DeveloperCubit, DeveloperState>(
            builder: (context, state) {
              if (state is DeveloperLoading ) {
                return _buildShimmerLoading();
              } else if (state is DeveloperLoaded) {
                return _buildDeveloperGrid(state, context);
              } else if (state is DeveloperError) {
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

  Widget _buildShimmerLoading() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Number of columns
        crossAxisSpacing: 16.0, // Spacing between columns
        mainAxisSpacing: 16.0, // Spacing between rows
        childAspectRatio: 3 / 4.5, // Aspect ratio for the grid items
      ),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: mediaQueryHeight(context) * 0.02),
              // Shimmer effect for the image
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!, // Custom color for image shimmer
                highlightColor: Colors.grey[100]!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Shimmer effect for the card text
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      // Custom color for card text
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      // Custom color for card description
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 60,
                        height: 15,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeveloperGrid(DeveloperLoaded state, BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 4.0, // Spacing between columns
        mainAxisSpacing: 4.0, // Spacing between rows
        childAspectRatio: 3 /4, // Aspect ratio for the grid items
      ),
      itemCount: state.hasReachedMax
          ? state.developers.length
          : state.developers.length + 1, // +1 for loading indicator
      itemBuilder: (context, index) {
        if (index < state.developers.length) {
          final developer = state.developers[index];
          final isClickable = developer.count > 0; // Define your condition here

          return GestureDetector(
            onTap: isClickable
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllDevelopersProjectsScreen(
                          projectId: developer.id,
                          projectTitle: developer.name,
                          projectCount: developer.count,
                            projectContent: developer.description
                        ),
                      ),
                    );
                  }
                : null,
            child: _buildRegionCard(
              developer.name,
              developer.count,
              (developer.image.startsWith('http')
                  ? NetworkImage(
                      developer.image,
                    )
                  : AssetImage(ImageAssets.placeHolder) as ImageProvider),
              context,
            ),
          );
        } else {
          return Container(child: _buildShimmerLoading());
        }
      },
    );
  }

  Widget _buildRegionCard(
      String name, int number, ImageProvider image, context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
                image: image, height: 100, width: 100, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                      color: AppColors.dark, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${number} مشاريع ',
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w400
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
