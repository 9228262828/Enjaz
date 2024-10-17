import 'package:enjaz/shared/components/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:enjaz/shared/global/app_colors.dart';
import 'package:enjaz/shared/utils/app_routes.dart';
import 'package:enjaz/shared/utils/navigation.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import '../../../../shared/global/app_theme.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../controllers/auth_controller/auth_cubit.dart';
import '../../../controllers/auth_controller/auth_states.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                showToast(text: 'تم التسجيل بنجاح', state: ToastStates.SUCCESS);

                navigateFinalTo(
                    context: context, screenRoute: Routes.loginScreen);
              } else if (state is RegisterFailure) {
                showToast(text: state.error, state: ToastStates.ERROR);
              }
            },
            builder: (context, state) {
              bool isPasswordVisible = state is PasswordVisibilityState
                  ? state.isPasswordVisible
                  : false;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: mediaQueryHeight(context) * 0.08),
                    // Adjust the height to position the logo better
                    Image.asset( ImageAssets.logo, height: 100),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    Text(
                      'إنشاء حساب',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Full Name Field
                    TextField(
                      controller: fullNameController,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      decoration: customInputDecoration(
                          context, 'الاسم الكامل', 'أدخل الاسم'),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Email Field
                    TextField(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      controller: emailController,
                      decoration: customInputDecoration(context,
                          'البريد الإلكتروني', 'أدخل البريد الإلكتروني'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Phone Number Field with Country Code Dropdown
                    IntlPhoneField(
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor: Colors.white,
                        countryCodeStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      decoration: customInputDecoration(
                          context, 'رقم الهاتف', '1001234567'),
                      style: Theme.of(context).textTheme.bodyMedium,
                      initialCountryCode: 'EG',
                      onChanged: (phone) {
                        phoneController.text = phone.completeNumber;
                      },
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      decoration: customInputDecoration(
                        context,
                        'كلمة المرور',
                        'أدخل كلمة المرور',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .togglePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Confirm Password Field
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: !isPasswordVisible,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      decoration: customInputDecoration(
                        context,
                        'تأكيد كلمة المرور',
                        'أدخل تأكيد كلمة المرور',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .togglePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (passwordController.text.trim() ==
                              confirmPasswordController.text.trim()) {
                            context.read<AuthCubit>().register(
                                  emailController.text.trim(),
                                  fullNameController.text.trim(),
                                  phoneController.text.trim(),
                                  passwordController.text.trim(),
                                );
                          } else {
                            showToast(
                                text: 'Passwords do not match',
                                state: ToastStates.ERROR);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        child: state is RegisterLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.background)
                            : Text('إنشاء حساب',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    // Already have an account? Login
                    TextButton(
                      onPressed: () {
                        navigateTo(
                            context: context, screenRoute: Routes.loginScreen);
                      },
                      child: Text(
                        'هل لديك حساب من قبل؟ تسجيل الدخول',
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
