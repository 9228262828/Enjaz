import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/settings_controller/settings_cubit.dart';
import '../../../controllers/settings_controller/settings_states.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(ImageAssets.logo, height: 35), // Enjaz logo
        ),
        body: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            if (state is SettingInitial) {
              return _buildShimmerLoading(context);
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

  Widget _buildShimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 20,
              width: 150,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: mediaQueryHeight(context) * 0.02),
          _buildMenuShimmer(context),
        ],
      ),
    );
  }

  Widget _buildMenuShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(6, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: ListTile(
                leading: Icon(Icons.square, color: Colors.grey.shade300),
                title: Container(
                  height: 20,
                  width: 150,
                  color: Colors.grey.shade300,
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade300, size: 16),
              ),
            ),
          );
        }),
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
        _buildMenuItem(() {
          navigateTo(context: context, screenRoute: Routes.contactUsScreen);
        }, context, 'تواصل معنا', FontAwesomeIcons.headset),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {
          navigateTo(context: context, screenRoute: Routes.aboutUsScreen  );
        }, context, 'نبذة عنا', Icons.info_outline),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {
          navigateTo(context: context, screenRoute: Routes.termsAndConditionsScreen);
        }, context, 'الشروط والأحكام', Icons.description),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() {
          navigateTo(context: context, screenRoute: Routes.privacyPolicyScreen);
        }, context, 'سياسة الخصوصية', Icons.privacy_tip_outlined),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() { deleteAccount(context); }, context, 'حذف الحساب', Icons.delete_outline),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        _buildMenuItem(() { logout(context); }, context, 'تسجيل الخروج', Icons.logout_outlined),
        SizedBox(height: mediaQueryHeight(context) * 0.02),
        Text(
          '1.0.0 إصدار',
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
            title: Text('تأكيد تسجيل الخروج', style: Theme.of(context).textTheme.displayLarge),
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
            title: Text('تأكيد حذف الحساب', style: Theme.of(context).textTheme.displayLarge),
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