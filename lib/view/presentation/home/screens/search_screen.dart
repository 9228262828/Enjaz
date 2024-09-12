import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/shared/utils/navigation.dart';
import 'package:flutter/material.dart';

import '../../../../shared/global/app_theme.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: TextField(
                              controller: TextEditingController(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary),
                              decoration: customInputDecoration(
                                context,
                                'البحث عن منطقة، الكمبوند، المطور',
                                '',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth(context) * 0.02),
                        // Add some space between the icon and the text field
                        GestureDetector(
                          onTap: () {
                            navigateTo(context: context, screenRoute: Routes.advancedSearchScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1), // Border around the icon
                            ),
                            padding: EdgeInsets.all(8.0),
                            // Padding inside the icon container
                            child: const Icon(
                              Icons.tune, // Replace with the appropriate icon
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: mediaQueryHeight(context) * 0.01),
                  ButtonsTabBar(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelSpacing: 10,
                    unselectedDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.backgroundLight.withOpacity(0.5),
                    ),
                    buttonMargin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    height: mediaQueryHeight(context) * 0.05,
                    tabs: const [
                      Tab(child: Text("الكل")),
                      Tab(child: Text("الكمبوندات")),
                      Tab(child: Text("المناطق")),
                      Tab(child: Text("المطورين")),
                      Tab(child: Text("المشاريع")),
                    ],
                    controller: _tabController,
                    unselectedLabelStyle:
                        const TextStyle(color: AppColors.boldGrey),
                    labelStyle: const TextStyle(color: AppColors.dark),

                  ),
                ],
              ),
            )),
        backgroundColor: AppColors.background,
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              crossAxisAlignment:   CrossAxisAlignment.start,
                children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "عمليات البحث الرائجة",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),

              // Popular Searches Wrap for multi-column layout
              MyGridView(),
            ]),
            CategoryButton(text: 'الكمبوندات'),
            CategoryButton(text: 'المناطق'),
            CategoryButton(text: 'المطورين'),
            CategoryButton(text: 'المشاريع'),
          ],
        ),
      ),
    );
  }
}

// Helper widget for category buttons
class CategoryButton extends StatelessWidget {
  final String text;

  const CategoryButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

// Helper widget for search chips
class SearchChip extends StatelessWidget {
  final String label;

  const SearchChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped on: $label");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.house_siding,
              color: Colors.blue,
              size: 15,
            ),
            SizedBox(width: mediaQueryWidth(context) * 0.01),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  final List<String> popularSearches = [
    'كايرو جيت',
    'جون',
    'بالم هيلز القاهرة الجديدة',
    'أو ويست أوراسكوم',
    'فيلت',
    'ميڤيدا',
    'سولاري',
    'المونت الجلالة',
    'هاسيندا ويست',
    'زايد ايست',
    'ذا سكوير',
    'دستريكت 5',
    'بادية',
    'ماونتن ڤيو أكتوبر',
    'ماونتن ڤيو القاهرة الجديدة'
  ];

  // Initial number of items to show
  int _itemCount = 10;
  final int _totalItems = 15; // Total number of items in your list

  void _showMore() {
    setState(() {
      _itemCount = (_itemCount + 10).clamp(10, _totalItems);
    });
  }

  void _showLess() {
    setState(() {
      _itemCount = (_itemCount - 10).clamp(10, _totalItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:   CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.6, // Adjust height as needed
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                // Number of items per row
                mainAxisSpacing: 8.0,
                // Vertical spacing between items
                crossAxisSpacing: 7.0,
                // Horizontal spacing between items
                childAspectRatio: 2.8,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.055,
              ),
              itemCount: _itemCount + 1,
              itemBuilder: (context, index) {
                if (index == _itemCount) {
                  if (_itemCount < _totalItems) {
                    return GestureDetector(
                      onTap: () {
                        _showMore();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'اظهر المزيد',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: AppColors.primary),
                            ),
                          )),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        _showLess();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'اظهر أقل',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: AppColors.primary),
                            ),
                          )),
                    );
                  }
                }
                return SearchChip(label: popularSearches[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

