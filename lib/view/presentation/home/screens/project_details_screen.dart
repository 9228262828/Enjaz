import 'package:carousel_slider/carousel_slider.dart';
import 'package:enjaz/shared/components/toast_component.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/view/presentation/home/componants/appbar.dart';
import 'package:enjaz/view/presentation/home/componants/price_format.dart';
import 'package:enjaz/view/presentation/home/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';
import '../componants/speed_dial.dart';
import '../componants/table.dart';
import '../componants/zoom_sheet.dart';
import '../data/project_model.dart';



class ProjectDetailScreen extends StatefulWidget {
  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();


  @override
  Widget build(BuildContext context) {
    // Retrieve the project data from the arguments
    final Project project =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Project;
    final List<String> imageGallery = project.gallery ?? [];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
           appbar(title: project.title??'', ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Image Gallery using CarouselSlider
                    if (imageGallery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _openFullScreenGallery(
                              context, imageGallery, _currentImageIndex);
                        },
                        child: SizedBox(
                          height: mediaQueryHeight(context) * 0.3,
                          child: Stack(
                            children: [
                              // Main carousel slider with images
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.30,
                                child: CarouselSlider.builder(
                                  carouselController: _carouselController,
                                  // Add the controller here
                                  itemCount: imageGallery.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return Container(
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          imageGallery[index],
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  size: 50,
                                                  color: AppColors.primary,
                                                ));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: mediaQueryHeight(context) * 0.30,
                                    viewportFraction: 1.0,
                                    initialPage: _currentImageIndex,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentImageIndex = index;
                                      });
                                    },
                                  ),
                                ),
                              ),

                              // Carousel indicators
                              Positioned(
                                bottom: mediaQueryHeight(context) * 0.03,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      imageGallery.length, (index) {
                                    return Container(
                                      width: _currentImageIndex == index ? 12 : 8,
                                      height: _currentImageIndex == index ? 12 : 8,
                                      margin: EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentImageIndex == index
                                            ? AppColors.primary
                                            : Colors.grey[100],
                                      ),
                                    );
                                  }),
                                ),
                              ),



                             /* Positioned(
                                top: mediaQueryHeight(context) * 0.16,
                                left: mediaQueryWidth(context) * 0.04,
                                right: mediaQueryWidth(context) * 0.04,
                                child: SizedBox(
                                  width: mediaQueryWidth(context) * 0.9,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: project.sections!.developer?.image !=
                                                    null &&
                                                project.sections!.developer!.image !=
                                                    "false"
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image(
                                                  image: NetworkImage(project
                                                      .sections!.developer!.image!),
                                                  fit: BoxFit.cover,
                                          ),
                                              )
                                            : SizedBox(),
                                      ),
                                      SizedBox(
                                        width: mediaQueryHeight(context) * 0.02,
                                      ),
                                      Expanded(
                                        child: Text(
                                          project.sections!.developer?.name ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                            color: AppColors.background,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),

                    // Thumbnail images row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        height: mediaQueryHeight(context) * 0.10,
                        // Thumbnail container height
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageGallery.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Update the carousel slider to the tapped thumbnail
                                setState(() {
                                  _currentImageIndex = index;
                                });
                                _carouselController.animateToPage(index);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                width: 80,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _currentImageIndex == index
                                        ? AppColors.primary
                                        : Color(0xFFFEAEAEA),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    imageGallery[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 30,
                                          color: AppColors.primary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Property details and price overlay
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:  MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "السعر يبدأ من ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                  PriceWidget(
                                    price:project.price![0],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Updated color for clarity
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Project Title
                          Text(
                            project.title ?? 'No Title',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize: 20,
                                  color: Color(0xFF0F0F0F),
                                ),
                          ),
                          SizedBox(height: mediaQueryHeight(context) * 0.02),

                          // Project Description
                          Text(
                            project.yoastdescription?.first ?? 'No description available',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              height: 1.5, // Adjust the line height
                            ),
                          ),


                          SizedBox(height: mediaQueryHeight(context) * 0.02),
                          ProjectDetails(
                            project: project,
                          ),
                          /* Text(
                            project.content ?? 'No content available',
                          ),*/

                          SizedBox(height: mediaQueryHeight(context) * 0.02),

                          Container(
                            width: mediaQueryWidth(context) * 0.95,
                            height: mediaQueryHeight(context) * 0.16,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color(0xFFFEAEAEA),
                                )),
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:   CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text("تواصل معنا",
                                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                          height: 1.5,
                                          fontSize: 20,
                                        )),
                                  ),
                                  SizedBox(height: mediaQueryHeight(context) * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(                  onTap: () {
                                        makePhoneCall();
                                      },
                                          child: Image.asset(ImageAssets.phone,color:  AppColors.offBlue,width:   mediaQueryWidth(context) * 0.14,)),
                                      GestureDetector(  onTap: () {
                                        openWhatsApp(
                                            text: '  استفساراي عن ${project.title} '
                                        );

                                      },child: Image.asset(ImageAssets.whatsApp,width:   mediaQueryWidth(context) * 0.14,)),
                                      GestureDetector( onTap: () {
                                        openGmail();
                                      },child: Image.asset(ImageAssets.email,width:   mediaQueryWidth(context) * 0.14,)),
                                      GestureDetector(
                                        onTap: (){
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: ScheduleBottomSheet());
                                            },
                                          );
                                        },
                                          child: Image.asset(ImageAssets.zoom,width:   mediaQueryWidth(context) * 0.14,)),


                                    ],
                                  ),
                                ]
                              ),
                            )
                          ),
                         /* Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ScheduleBottomSheet());
                                  },
                                );
                              },
                              child: Container(
                                  width: mediaQueryWidth(context) * 0.9,
                                  height: mediaQueryHeight(context) * 0.08,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFFFEAEAEA),
                                      )),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.calendar_month_sharp, color: Color(0xFF0F0F0F)),
                                        SizedBox(
                                          width: mediaQueryWidth(context) * 0.02,
                                        ),
                                        Text(
                                          "حدد موعد مقابلة",
                                          style:
                                              Theme.of(context).textTheme.titleSmall,
                                        ),
                                      ])),
                            ),
                          ),*/
                          SizedBox(height: mediaQueryHeight(context) * 0.03),

                          // Projects from the same developer

                          /*if (project.sections?.developer == null) ...[
                            Center(
                                child: Text(
                              "لا يوجد مشاريع متاحة",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primary,
                                  ),
                            )),
                          ]*/
                        ],
                      ),
                    ),
                    if (project.sections?.developer != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "مشاريع اخرى من ${project.sections!.developer!.name}",
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),

                      // BlocProvider to fetch related projects
                      BlocProvider(
                        create: (context) =>
                        ProjectCubit()
                          ..fetchProjects(
                            projectId: project.sections!.developer!.id as int,
                            pageCount: 10,
                          ),
                        child: BlocBuilder<ProjectCubit, ProjectState>(
                          builder: (context, state) {
                            if (state is ProjectLoading) {
                              return SizedBox(
                                height: mediaQueryHeight(context) * 0.27,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3, // Show shimmer for 3 items
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Shimmer.fromColors(
                                        baseColor:Color(0xFF3F8FC),
                                        highlightColor:Colors.grey[300]!,
                                        child: Card(
                                          elevation: 5,
                                          child: Container(

                                            height: mediaQueryHeight(context) *
                                                0.24,
                                            width:
                                            mediaQueryWidth(context) * .45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              color: Colors
                                                  .grey, // Background color for the card
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: mediaQueryHeight(
                                                      context) *
                                                      0.14,
                                                  width:
                                                  mediaQueryWidth(context),

                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[
                                                      300],
                                                      borderRadius: BorderRadius
                                                          .circular(15)
                                                  ), // Placeholder for image
                                                ),
                                                Container(
                                                  height: 20,
                                                  color: Colors.grey[400],
                                                  // Placeholder for title
                                                  margin:
                                                  const EdgeInsets.all(8.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (state is ProjectLoaded) {
                              return SizedBox(
                                height: mediaQueryHeight(context) * 0.27,
                                child: ListView.builder(

                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.projects.length,
                                  itemBuilder: (context, index) {
                                    final project = state.projects[index];
                                    return GestureDetector(
                                      onTap: index > 0
                                          ? () {
                                        navigateTo(
                                          context: context,
                                          screenRoute: Routes
                                              .projectDetailsScreen,
                                          arguments: project,
                                        );
                                      }
                                          : () {
                                        showToast(
                                            text: "انت الان بالفعل داخل المشروع",
                                            state: ToastStates.WARNING);
                                      },
                                      child:Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
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
                            } else if (state is ProjectError) {
                              return Center(child: Text(state.message));
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonAnimator:   FloatingActionButtonAnimator.scaling,

       /* floatingActionButton: SpeedDial(
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
            buildWhatsapp(context,project.title.toString()),
          ],
        ),*/
      ),
    );
  }


  // Function to open full-screen gallery
  void _openFullScreenGallery(
      BuildContext context, List<String> imageGallery, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenGallery(
          gallery: imageGallery,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

class FullScreenGallery extends StatefulWidget {
  final List<String> gallery;
  final int initialIndex;

  FullScreenGallery({required this.gallery, this.initialIndex = 0});

  @override
  _FullScreenGalleryState createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("${_currentIndex + 1} / ${widget.gallery.length}"),
      ),
      body: PhotoViewGallery.builder(
        itemCount: widget.gallery.length,
        pageController: PageController(initialPage: _currentIndex),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.gallery[index]),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Image.asset(ImageAssets.logo),
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            filterQuality: FilterQuality
                .high, // Apply high-quality filter in full-screen as well
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
