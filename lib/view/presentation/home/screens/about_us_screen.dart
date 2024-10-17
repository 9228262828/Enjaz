import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/view/presentation/home/componants/appbar.dart';
import 'package:enjaz/view/presentation/home/screens/privacy_screen.dart';
import 'package:enjaz/view/presentation/home/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/settings_controller/privacy_cubit.dart';
import '../../../controllers/settings_controller/privacy_states.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => AboutUsCubit()..fetchAboutUs(),
          child: BlocBuilder<AboutUsCubit, AboutUsState>(
            builder: (context, state) {
              if (state is AboutUsLoading) {
                return Center(child: buildShimmerLoading(context));
              } else if (state is AboutUsLoaded) {
                return Column(
                  children: [
                    appbar(title: "نبذة عننا", ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.aboutUs.title,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(height: mediaQueryHeight(context) * 0.02),
                            Text(state.aboutUs.content,style: Theme.of(context).textTheme.displayMedium,
                            ),  // Display the stripped content
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is AboutUsError) {
                return Center(child: Text('Error: ${state.errorMessage}'));
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
