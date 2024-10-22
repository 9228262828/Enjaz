
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';


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
        title: Text("${_currentIndex + 1} / ${widget.gallery.length}",style:  Theme.of(context).textTheme.displayLarge,),
        actions: [
          IconButton(
            icon: const Icon(Icons.close,color:   AppColors.boldGrey  ,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
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
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}