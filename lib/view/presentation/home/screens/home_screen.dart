import 'package:flutter/material.dart';

import '../../../../shared/global/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  Color _appBarBackgroundColor = Colors.white; // Default color

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        // Update background color based on scroll position
        if (_scrollController.hasClients) {
          final offset = _scrollController.offset;
          if (offset > 100) {
            // You can adjust this value
            setState(() {
              _appBarBackgroundColor = Colors.black; // Color when pinned
            });
          } else {
            setState(() {
              _appBarBackgroundColor = Colors.white; // Default color
            });
          }
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                      ),
                      const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: _appBarBackgroundColor,
            // Dynamic color
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: Icon(Icons.search),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
              //  controller: _emailOrPhoneController,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                decoration: customInputDecoration(
                  context,
                  'البريد الإلكتروني ',
                  'أدخل البريد الإلكتروني ',
                ),
              ),
            ),
          ),
         SliverToBoxAdapter(
           child: Column(
             children: [
               Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),Text('data'),
               Text('data'),
               Text('data'),
             ],
           ),
         )
        ],
      ),
    );
  }
}
