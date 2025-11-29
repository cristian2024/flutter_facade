import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {

  TextTheme getTextTheme() {
    return getThemeData().textTheme;
  }

  ThemeData getThemeData(){
    return Theme.of(this);
  }
}