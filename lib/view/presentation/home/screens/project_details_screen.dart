import 'package:carousel_slider/carousel_slider.dart';
import 'package:enjaz/shared/components/toast_component.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/projects_controllers/project_cubit.dart';
import '../../../controllers/projects_controllers/project_states.dart';
import '../data/project_model.dart';

class ProjectDetailScreen extends StatefulWidget {
  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Retrieve the project data from the arguments
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;
    final List<String> imageGallery = project.gallery ?? [];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            project.title ?? '',
            style: Theme.of(context).textTheme.displayLarge,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    height: mediaQueryHeight(context) * 0.35,
                    child: Stack(
                      children: [
                        // Main carousel slider with images
                        SizedBox(
                          height: mediaQueryHeight(context) * 0.30,
                          child: CarouselSlider.builder(
                            itemCount: imageGallery.length,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
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
                          bottom: mediaQueryHeight(context) * 0.09,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(imageGallery.length, (index) {
                              return Container(
                                width: _currentImageIndex == index ? 12 : 8,
                                height: _currentImageIndex == index ? 12 : 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentImageIndex == index
                                      ? AppColors.primary
                                      : Colors.grey,
                                ),
                              );
                            }),
                          ),
                        ),

                        // Property details and price overlay
                        Positioned(
                          bottom: mediaQueryHeight(context) * 0.02,
                          left: mediaQueryWidth(context) * 0.04,
                          right: mediaQueryWidth(context) * 0.04,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "سعر الفيلا يبدأ من ${project.price![0]} ج.م ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(
                                        project.sections!.developer?.image != null &&
                                            project.sections!.developer!.image != "false"
                                            ? project.sections!.developer!.image!
                                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR83W4yK_tbcmYD3H94oUY5PpAh1Ud125YwgaoqPpPs9aYO6qPRpsn-2Tc0t1fJZ4MJnMg&usqp=CAU', // Placeholder image
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQueryHeight(context) * 0.02,
                                ),
                                Expanded(
                                  child: Text(
                                    project.sections!.developer?.name ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),

              // Project Titlecd
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Title
                    Text(
                      project.title ?? 'No Title',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primary,
                          ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),

                    // Project Description
                    Text(
                      project.yoastdescription?.first ??
                          'No description available',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),

                    // Project Location
                    buildInfoRow(
                      "موقع المشروع",
                      project.location?.first ?? 'No location available',
                    ),
                    Divider(color: Colors.grey),

                    // Project Type
                    buildInfoRow("نوع المشروع", "شاليهات"),
                    Divider(color: Colors.grey),

                    // Project Price
                    buildInfoRow(
                      "الأسعار تبدأ من",
                      project.price != null && project.price!.isNotEmpty
                          ? '${project.price![0].toString()} ج.م'
                          : 'No price available',
                    ),
                    Divider(color: Colors.grey),

                    // Payment Systems
                    buildInfoRow(
                      "أنظمة السداد",
                      project.downpayment != null &&
                              project.downpayment!.isNotEmpty &&
                              project.installment != null &&
                              project.installment!.isNotEmpty
                          ? "مقدم ${project.downpayment![0]}, ${project.installment![0]} تقسيط"
                          : "No payment systems available",
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                   /* Text(
                      project.content ?? 'No content available',
                    ),*/
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: mediaQueryWidth(context) * 0.9,
                        height: mediaQueryHeight(context) * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:   Border.all(
                            color: AppColors.dark,
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call_to_action),
                            SizedBox(width: mediaQueryWidth(context) * 0.02,),
                            Text("حدد موعد مقابله",style: Theme.of(context).textTheme.titleSmall,),

                          ]
                        )
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),

                    // Projects from the same developer
                    if (project.sections?.developer != null) ...[
                      Text(
                        "مشاريع اخرى من ${project.sections!.developer!.name}",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: AppColors.primary,
                                ),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),

                      // BlocProvider to fetch related projects
                      BlocProvider(
                        create: (context) => ProjectCubit()
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
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.white,
                                        child: Card(
                                          elevation: 5,
                                          child: Container(

                                            height: mediaQueryHeight(context) *
                                                0.24,
                                            width:
                                                mediaQueryWidth(context) * .45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
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

                                                  decoration:   BoxDecoration(
                                                      color: Colors.grey[
                                                      300],
                                                    borderRadius: BorderRadius.circular(15)
                                                  ),// Placeholder for image
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
                                  padding: const EdgeInsets.all(8.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.projects.length,
                                  itemBuilder: (context, index) {
                                    final project = state.projects[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: index > 0
                                            ? () {
                                                navigateTo(
                                                  context: context,
                                                  screenRoute: Routes
                                                      .projectDetailsScreen,
                                                  arguments: project,
                                                );
                                              }
                                            : (){
                                          showToast(text: "انت الان بالفعل داخل المشروع", state: ToastStates.WARNING);
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            height: mediaQueryHeight(context) *
                                                0.24,
                                            width:
                                                mediaQueryWidth(context) * .45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15.0),
                                                    topRight:
                                                        Radius.circular(15.0),
                                                  ),
                                                  child: Image.network(
                                                    project.image ?? 'No image',
                                                    fit: BoxFit.fill,
                                                    height: mediaQueryHeight(
                                                            context) *
                                                        0.14,
                                                    width: mediaQueryWidth(
                                                        context),
                                                  ),
                                                ),
                                                Text(
                                                  project.title ?? 'No title',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
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
                            } else if (state is ProjectError) {
                              return Center(child: Text(state.message));
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      ],
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
