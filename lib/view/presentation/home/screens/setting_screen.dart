import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/shared/utils/app_assets.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';
import '../../auth/screens/login_screen.dart';
import '../controllers/settings_controller/settings_cubit.dart';
import '../controllers/settings_controller/settings_states.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: SvgPicture.asset(ImageAssets.logo, height: 40), // Enjaz logo
        ),
        body: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            if (state is SettingInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SettingError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is SettingUnauthenticated) {
              return _buildUnauthenticatedView(context);
            } else if (state is SettingLoaded) {
              return _buildAuthenticatedView(context, state.userName);
            }
            return Container(); // Fallback
          },
        ),
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
              // Handle login action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('تسجيل الدخول'),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          _buildMenu(context),
        ],
      ),
    );
  }

  Widget _buildAuthenticatedView(BuildContext context, String userName) {
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
            'مرحباً، $userName',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _buildMenu(context),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(() {}, context, 'تواصل معنا', Icons.phone),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {}, context, 'نبذة عنا', Icons.info_outline),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {}, context, 'الشروط والأحكام', Icons.description),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(
            () {}, context, 'سياسة الخصوصية', Icons.privacy_tip_outlined),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {deleteAccount(context);}, context, 'حذف الحساب', Icons.delete_outline),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {logout(context);}, context, 'تسجيل الخروج', Icons.logout_outlined),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        Text(
          '3.2.153 إصدار',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Colors.grey),
        ),
        Text('Copyright 2024 - Enjaz ©',
            style: Theme.of(context).textTheme.displayLarge),
      ],
    );
  }

  Widget _buildMenuItem(
      Function()? onTap, BuildContext context, String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.boldBlack.withOpacity(.1),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        onTap: onTap,
      ),
    );
  }


  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('تأكيد تسجيل الخروج',style:   Theme.of(context).textTheme.displayLarge,),
            content: Text('هل أنت متأكد من تسجيل الخروج؟'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Call the logout method from SettingCubit
                  context.read<SettingCubit>().logout();

                  // Navigate to the login screen
                  navigateTo(context: context, screenRoute: Routes.loginScreen);
                },
                child: Text('تأكيد'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('تأكيد حذف الحساب',style:   Theme.of(context).textTheme.displayLarge,),
            content: Text('هل أنت متأكد من حذف حسابك؟'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog

                  context.read<SettingCubit>().deleteAccount();
                  navigateTo(context: context, screenRoute: Routes.loginScreen);
                },
                child: Text('تأكيد'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
