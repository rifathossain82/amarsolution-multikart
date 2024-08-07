import 'package:amarsolution_multikart/src/features/dashboard/view/pages/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static const String dashboard = '/';
  static const String login = '/login';



  static final routes = [
    GetPage(
      name: RouteGenerator.dashboard,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: RouteGenerator.login,
      page: () => Container(),
    ),
  ];
}
