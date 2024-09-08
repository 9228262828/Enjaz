import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final Color primaryColor = Colors.blue;

  // List of widgets for each screen
  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    Center(child: Text('My Units Screen')), // Replace with your screen widget
    Center(child: Text('Search Screen')), // Replace with your screen widget
    Center(child: Text('Explore Screen')), // Replace with your screen widget
    Center(child: Text('More Screen')), // Replace with your screen widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'My Units',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor, // Set the selected icon and label color to primary
          unselectedItemColor: Colors.grey, // Set the unselected icon and label color to grey
          onTap: _onItemTapped,
        ),

        // Body changes according to the selected tab
        body: _screens[_selectedIndex],
      ),
    );
  }
}


