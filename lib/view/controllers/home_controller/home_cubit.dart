import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageCubit extends Cubit<Locale> {
  LanguageCubit(Locale initialLocale) : super(initialLocale);

  void changeLocale(Locale locale, BuildContext context) async {
    context.setLocale(locale);
    emit(locale);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }
}

