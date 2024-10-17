import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/view/presentation/home/componants/appbar.dart';
import 'package:enjaz/view/presentation/home/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart'; // Import Shimmer package

import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/settings_controller/settings_cubit.dart';
import '../../../controllers/settings_controller/settings_states.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

          body: BlocBuilder<SettingCubit, SettingState>(
            builder: (context, state) {
              if (state is SettingInitial) {
                // Display shimmer effect while loading
                return _buildShimmerEffect(context);
              } else if (state is SettingError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is SettingUnauthenticated) {
                return Center(child: _buildUnauthenticatedView(context));
              } else if (state is SettingLoaded) {
                return Column(
                  children: [
                    appbar(title: 'الملف الشخصي',),
                    Expanded(child: _buildProfileContent(state, context)),
                  ],
                );
              }
              return Container(); // Fallback
            },
          ),
        ),
      ),
    );
  }

  // Shimmer effect for loading UI
  Widget _buildShimmerEffect(context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Shimmer for profile picture
          Shimmer.fromColors(
            baseColor:Color(0xFF3F8FC),
            highlightColor:Colors.grey[300]!,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
            ),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.08),
          // Shimmer for name, email, phone, etc.
          Shimmer.fromColors(
            baseColor:Color(0xFF3F8FC),
            highlightColor:Colors.grey[300]!,
            child: Column(
              children: [
                Container(
                  width: mediaQueryWidth(context) * .9,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                Container(
                  width: mediaQueryWidth(context) * .9,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                Container(
                  width: mediaQueryWidth(context) * .9,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                Container(
                  width: mediaQueryWidth(context) * .4,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),


              ],
            ),
          ),
        ],
      ),
    );
  }

  // The actual content after data is loaded
  Widget _buildProfileContent(SettingLoaded state, context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          // User Profile Picture
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 60, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),

          // Editable Name
          TextFormField(
            initialValue: state.userName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              labelText: 'الاسم',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          SizedBox(height: 20),

          // Editable Email
          TextFormField(
            initialValue: state.userEmail,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              labelText: ' البريد الإلكتروني',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          SizedBox(height: 20),

          // Editable Phone Number
          TextFormField(
            initialValue: state.userPhone,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              labelText: ' رقم الهاتف',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          SizedBox(height: 20),

          // Static Login Method

          SizedBox(height: 20),

          // Delete Account Option
          ElevatedButton.icon(
            onPressed: () {
              deleteAccount(context);
            },
            icon: Icon(Icons.delete, color: Colors.red),
            label: Text('حذف الحساب', style: TextStyle(color: Colors.red)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.red),
              textStyle: TextStyle(color: Colors.red),
            ),
          ),
          SizedBox(height: 10),

          // Logout Option
          ElevatedButton.icon(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout, color: Colors.blue),
            label: Text('تسجيل الخروج', style: TextStyle(color: Colors.blue)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.blue),
              textStyle: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 60, color: Colors.grey[600]),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          Text(
            'مرحباً، مستخدم Enjaz',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              navigateTo(context: context, screenRoute: Routes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text('تسجيل الدخول'),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.02),
        ],
      ),
    );
  }
}
