import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/utils/app_assets.dart';

class BannerWithImages extends StatefulWidget {
  @override
  _BannerWithImagesState createState() => _BannerWithImagesState();
}

class _BannerWithImagesState extends State<BannerWithImages> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  // List of image URLs or asset paths
  final List<String> _images = [
     ImageAssets.logo,
     ImageAssets.logo,
     ImageAssets.logo,
     ImageAssets.logo,
  ];

  @override
  void initState() {
    super.initState();

    // Automatically change the image every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaQueryHeight(context)*.2, // Set the height of the banner
      child: PageView.builder(
        controller: _pageController,
        itemCount: _images.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: mediaQueryWidth(context)*.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:   Border.all(
                  color: Colors.grey.shade100,
                )

              ),
              child: SvgPicture.asset(_images[index]),
            ),
          );
        },
      ),
    );
  }
}
