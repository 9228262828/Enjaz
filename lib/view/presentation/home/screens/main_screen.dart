import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/view/presentation/home/screens/setting_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;



  // Handle navigation on item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of widgets for each screen, defined within the build method
    final List<Widget> _screens = <Widget>[
      HomeScreen(
        goSearch: () {
          _onItemTapped(2);
        }
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('My Units Screen'),
            ElevatedButton(
              onPressed: () {
                _onItemTapped(0); // Navigate to the Home screen
              },
              child: Text('Go to Home Screen'),
            ),
          ],
        ),
      ),
      Center(child: Text('Search Screen')), // Replace with your screen widget
      Center(child: Text('Explore Screen')), // Replace with your screen widget
      SettingScreen(), // Replace with your screen widget
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(

              icon: Icon(Icons.home),
              label: 'الرئيسية',
              tooltip: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'المشروعات',
              tooltip: 'المشروعات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'البحث',
              tooltip: 'البحث',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'المناطق',tooltip: 'المناطق',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'المزيد',
              tooltip: 'المزيد',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primary, // Set the selected icon and label color to primary
          unselectedItemColor: Colors.grey, // Set the unselected icon and label color to grey
          onTap: _onItemTapped,
        ),

        // Body changes according to the selected tab
        body: _screens[_selectedIndex],
      ),
    );
  }
}
