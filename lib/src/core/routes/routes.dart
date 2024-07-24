import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String login = '/login';



  static final routes = [
    GetPage(
      name: RouteGenerator.splash,
      page: () => Container(),
    ),
  ];
}
