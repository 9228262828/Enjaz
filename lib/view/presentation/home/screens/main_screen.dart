import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/shared/utils/app_assets.dart';
import 'package:enjaz/view/presentation/home/screens/all_projects_screen.dart';
import 'package:enjaz/view/presentation/home/screens/search_screen.dart';
import 'package:enjaz/view/presentation/home/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'all_cities_screen.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> _screens = <Widget>[
      HomeScreen(
        goSearch: () {
          _onItemTapped(2);

        }
        ,
        goAllProjects: (){

          _onItemTapped(1);
        },
      ),
      ProjectsScreen(goSearch: () {
        _onItemTapped(2);

      }),
      SearchScreen(),
      AllCitiesScreen(goSearch: () {
        _onItemTapped(2);
      }),
      const SettingScreen(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          type:  BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items:  [
            BottomNavigationBarItem(

              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  ImageAssets.home,
                  width: 24,
                  height: 24,
                ),
              ),
              label: 'الرئيسية',
              tooltip: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  ImageAssets.apartment,
                  width: 24,
                  height: 24,
                ),
              ),
              label: 'المشروعات',
              tooltip: 'المشروعات',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  ImageAssets.search,
                  width: 24,
                  height: 24,
                ),
              ),
              label: 'البحث',
              tooltip: 'البحث',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  ImageAssets.location,
                  width: 24,
                  height: 24,
                ),
              ),
              label: 'المناطق',tooltip: 'المناطق',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 4 ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  ImageAssets.more_information,
                  width: 24,
                  height: 24,
                ),
              ),
              label: 'المزيد',
              tooltip: 'المزيد',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),


        body: _screens[_selectedIndex],
      ),
    );
  }
}
