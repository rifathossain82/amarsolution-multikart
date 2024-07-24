import 'dart:math';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void unFocusKeyboard() {
    if (FocusScope.of(this).hasFocus) FocusScope.of(this).unfocus();
  }

  dynamic get getArguments => ModalRoute.of(this)?.settings.arguments;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  Size get screenSize => MediaQuery.of(this).size;

  double get minScreenSize =>
      min(MediaQuery.of(this).size.height, MediaQuery.of(this).size.width);

  double get maxScreenSize =>
      max(MediaQuery.of(this).size.height, MediaQuery.of(this).size.width);

  TextTheme get appTextTheme => Theme.of(this).textTheme;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  void openDrawer() => Scaffold.of(this).openDrawer();

  void closeDrawer() => Scaffold.of(this).closeDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  void closeEndDrawer() => Scaffold.of(this).closeEndDrawer();

  bool get isDrawerOpen => Scaffold.of(this).isDrawerOpen;
}
