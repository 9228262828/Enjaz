import 'package:flutter/material.dart';

abstract class MobileViewState {}

class MobileViewInitial extends MobileViewState {}


class MobileViewLocaleChanged extends MobileViewState {
  final Locale locale;


  MobileViewLocaleChanged(this.locale);
}
