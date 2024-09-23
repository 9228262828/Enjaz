import 'package:enjaz/shared/components/notifications.dart';
import 'package:enjaz/shared/global/app_theme.dart';
import 'package:enjaz/shared/network/dio_helper.dart';
import 'package:enjaz/shared/utils/app_routes.dart';
import 'package:enjaz/shared/utils/app_strings.dart';
import 'package:enjaz/view/controllers/auth_controller/auth_cubit.dart';
import 'package:enjaz/view/controllers/cities_controller/cities_cubit.dart';
import 'package:enjaz/view/controllers/developers_controllers/developers_cubit.dart';
import 'package:enjaz/view/controllers/projects_controllers/project_cubit.dart';
import 'package:enjaz/view/controllers/search_controllers/search_cubit.dart';
import 'package:enjaz/view/controllers/settings_controller/settings_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final NotificationService _notificationService = NotificationService();
  await _notificationService.initialize();
  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => DeveloperCubit()),
        BlocProvider(create: (context) => DevelopersFeaturedCubit()),
        BlocProvider(create: (context) => ProjectCubit()),
        BlocProvider(create: (context) => AllProjectCubit()),
        BlocProvider(create: (context) => AllProjectsFeaturedCubit()),
        BlocProvider(create: (context) => CitiesCubit()),
        BlocProvider(create: (context) => CitiesAllCubit()),
        BlocProvider(create: (context) => SearchCubit()),
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
