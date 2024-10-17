import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/view/presentation/home/componants/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/settings_controller/privacy_cubit.dart';
import '../../../controllers/settings_controller/privacy_states.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        body: BlocProvider(
          create: (context) =>
          PrivacyPolicyCubit()
            ..fetchPrivacyPolicy(),
          child: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
            builder: (context, state) {
              if (state is PrivacyPolicyLoading) {
                return Center(child: buildShimmerLoading(context));
              } else if (state is PrivacyPolicyLoaded) {
                return Column(
                  children: [
                    appbar(title: 'سياسة الخصوصية',),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.privacyPolicy.title,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge,
                            ),
                            SizedBox(height: mediaQueryHeight(context) * 0.02),
                            Text(state.privacyPolicy.content, style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium,
                            ), // Display the stripped content
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is PrivacyPolicyError) {
                return Center(child: Text('Error: ${state.error}'));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

}
  Widget buildShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:Color(0xFF3F8FC),
      highlightColor:Colors.grey[300]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for title
            Container(
              width: double.infinity,
              height: 30.0,
              color: Colors.grey,
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            // Shimmer for the content
            Container(
              width: double.infinity,
              height: 150.0,
              color: Colors.grey,
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.02),
            // Additional shimmer lines for content
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
