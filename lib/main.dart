import 'package:easy_localization/easy_localization.dart';
import 'package:enjaz/shared/global/app_theme.dart';
import 'package:enjaz/shared/utils/app_routes.dart';
import 'package:enjaz/shared/utils/app_strings.dart';
import 'package:enjaz/view/controllers/home_controller/home_cubit.dart';
import 'package:enjaz/view/presentation/auth/controller/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await EasyLocalization.ensureInitialized();

//  final SharedPreferences prefs = await SharedPreferences.getInstance();

 /* final String? storedLocale = prefs.getString('locale');
  final Locale initialLocale = storedLocale != null
      ? Locale(storedLocale)
      : WidgetsBinding.instance.window.locale;*/

 /* final bool? isDarkMode = prefs.getBool('isDarkMode');
  final ThemeMode initialThemeMode = isDarkMode != null
      ? (isDarkMode ? ThemeMode.dark : ThemeMode.light)
      : (WidgetsBinding.instance.window.platformBrightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light);*/

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: lightTheme,

        //   localizationsDelegates: context.localizationDelegates,
      //  supportedLocales: context.supportedLocales,
        initialRoute: Routes.splash,
        onGenerateRoute: RouteGenerator.getRoute,
        //  locale: locale,
      ),
    );


  }
}
