import 'package:enjaz/shared/components/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/navigation.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_states.dart';
import '../../../../shared/global/app_colors.dart';
import '../../../../shared/global/app_theme.dart';
import '../../../../shared/utils/app_values.dart';

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
                    SizedBox(height: mediaQueryHeight(context) * 0.2),
                    Image.asset('assets/images/logo.png', height: 100),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    Text(
                      'تسجيل الدخول',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.primary,
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
