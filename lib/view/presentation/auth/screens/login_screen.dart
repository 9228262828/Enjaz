import 'package:enjaz/shared/components/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/global/app_theme.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../controllers/auth_controller/auth_cubit.dart';
import '../../../controllers/auth_controller/auth_states.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Add a state to manage password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                showToast(
                    text: 'تم تسجيل الدخول بنجاح', state: ToastStates.SUCCESS);
                navigateFinalTo(
                    context: context, screenRoute: Routes.homeScreen);
              } else if (state is LoginFailure) {
                print(state.error);
                print("state.error");
                showToast(text: "حاول مرة أخرى", state: ToastStates.ERROR);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: mediaQueryHeight(context) * 0.05),
                    Image.asset( ImageAssets.logo, height: 40),
                    SizedBox(height: mediaQueryHeight(context) * 0.1),
                    Text(
                      'تسجيل الدخول',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 22
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.04),
                    // Email or Phone Field
                    TextField(
                      controller: _emailOrPhoneController,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      decoration: customInputDecoration(
                        context,
                        'البريد الإلكتروني ',
                        'أدخل البريد الإلكتروني ',
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible, // Toggle visibility
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      decoration: customInputDecoration(
                        context,
                        'كلمة المرور',
                        'أدخل كلمة المرور',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible =
                                  !_isPasswordVisible; // Toggle state
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String emailOrPhone =
                              _emailOrPhoneController.text.trim();
                          String password = _passwordController.text.trim();
                          context
                              .read<AuthCubit>()
                              .login(emailOrPhone, password);
                        },
                        child: state is LoginLoading
                            ? CircularProgressIndicator(
                                color: AppColors.background)
                            : Text(
                                'تسجيل الدخول',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: AppColors.dark,
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Create an account Button
                    TextButton(
                      onPressed: () {
                        navigateTo(
                            context: context,
                            screenRoute: Routes.registerScreen);
                      },
                      child: Text(
                        'إنشاء حساب',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    TextButton(
                      onPressed: () async {
                        // Save the login state in SharedPreferences
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool(
                            'isLoggedIn', true); // Save the login state

                        // Navigate to the home screen
                        navigateTo(
                          context: context,
                          screenRoute: Routes.homeScreen,
                        );
                      },
                      child: Text(
                        'الصفحة الرئيسية',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
