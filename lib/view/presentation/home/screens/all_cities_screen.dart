import 'package:enjaz/view/controllers/cities_controller/cities_states.dart';
import 'package:enjaz/view/presentation/home/componants/appbar.dart';
import 'package:enjaz/view/presentation/home/screens/allCities_projects_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../controllers/cities_controller/cities_cubit.dart';
import '../componants/speed_dial.dart';

class AllCitiesScreen extends StatefulWidget {
  final Function()? goSearch;

  const AllCitiesScreen({super.key, this.goSearch});

  @override
  _AllCitiesScreenState createState() => _AllCitiesScreenState();
}

class _AllCitiesScreenState extends State<AllCitiesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<CitiesCubit>().fetchCitiess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CitiesCubit, CitiesState>(
            builder: (context, state) {
              if (state is CitiesLoading && state.page == 1) {
                return _buildShimmerLoading();
              } else if (state is CitiesLoaded) {
                return Column(
                  children: [
                    appbar(title: 'كل المناطق', ),
                    Expanded(child: _buildCitiesGrid(state, context)),
                  ]
                );
              } else if (state is CitiesError) {
                return Center(child: Text(state.message));
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
        floatingActionButton: SpeedDial(
          activeIcon: Icons.close,
          icon: FontAwesomeIcons.headset,
          activeBackgroundColor: Colors.red.withOpacity(.5),
          foregroundColor: Colors.white,
          buttonSize: Size(50.0, 50.0),
          backgroundColor: AppColors.primary,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          children: [
            buildphone(context),
            buildWhatsapp(context,""),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: mediaQueryHeight(context) * 0.02),
              // Shimmer effect for the image
              Shimmer.fromColors(
                 baseColor:Color(0xFF3F8FC),
                    highlightColor:Colors.grey[300]!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.grey[400],
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
                      baseColor:Color(0xFF3F8FC),
                      highlightColor:Colors.grey[300]!,
                      child: Container(
                        width: 80,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Shimmer.fromColors(
                      baseColor:Color(0xFF3F8FC),
                      highlightColor:Colors.grey[300]!,
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

  Widget _buildCitiesGrid(CitiesLoaded state, BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 3.0, // Spacing between columns
        mainAxisSpacing: 3.0, // Spacing between rows
        childAspectRatio: 3 /3.5, // Aspect ratio for the grid items
      ),
      itemCount: state.hasReachedMax
          ? state.cites.length
          : state.cites.length + 1, // +1 for loading indicator
      itemBuilder: (context, index) {
        if (index < state.cites.length) {
          final city = state.cites[index];
          final isClickable = city.count > 0; // Define your condition here

          return GestureDetector(
            onTap: isClickable
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CitiesProjectsScreen(
                          projectId: city.id,
                          projectCount: city.count,
                          projectTitle: city.name,
                          projectContent:  city.description,
                        ),
                      ),
                    );
                  }
                : null,
            child: _buildRegionCard(
              city.name,
              city.count,
              (city.image.startsWith('http')
                  ? NetworkImage(
                      city.image,
                    )
                  : AssetImage(city.image) as ImageProvider),
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
        borderRadius: BorderRadius.circular(5.0),
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
                  maxLines: 1,
                  overflow:  TextOverflow.ellipsis,
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
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
