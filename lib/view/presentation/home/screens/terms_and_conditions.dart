import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/view/presentation/home/screens/privacy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/settings_controller/privacy_cubit.dart';
import '../../../controllers/settings_controller/privacy_states.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('الشروط والأحكام', style: Theme.of(context).textTheme.displayLarge,)),
        body: BlocProvider(
          create: (context) => TermsAndConditionsCubit()..fetchTermsAndConditions(),
          child: BlocBuilder<TermsAndConditionsCubit, TermsAndConditionsState>(
            builder: (context, state) {
              if (state is TermsAndConditionsLoading) {
                return Center(child: buildShimmerLoading(context));
              } else if (state is TermsAndConditionsLoaded) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.termsAndConditions.title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      Text(state.termsAndConditions.content,style: Theme.of(context).textTheme.displayMedium,
                      ),  // Display the stripped content
                    ],
                  ),
                );
              } else if (state is TermsAndConditionsError) {
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
