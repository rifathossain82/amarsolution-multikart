import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/features/cart/view/pages/cart_page.dart';
import 'package:amarsolution_multikart/src/features/category/view/pages/category_page.dart';
import 'package:amarsolution_multikart/src/features/dashboard/model/dashboard_nav_item.dart';
import 'package:amarsolution_multikart/src/features/home/view/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final dashboardController = Get.find<DashboardController>();

  final pages = <Widget>[
    const Homepage(),
    const CategoryPage(),
    const CartPage(),
    Container(),
    Container(),
  ];

  final List<DashboardNavItem> navItemsList = [
    DashboardNavItem(
      iconPath: AssetPath.homeIcon,
      activeIconPath: AssetPath.homeFilledIcon,
      label: "Home",
    ),
    DashboardNavItem(
      iconPath: AssetPath.categoryIcon,
      activeIconPath: AssetPath.categoryFilledIcon,
      label: "Category",
    ),
    DashboardNavItem(
      iconPath: AssetPath.cartIcon,
      activeIconPath: AssetPath.cartFilledIcon,
      label: "Cart",
    ),
    DashboardNavItem(
      iconPath: AssetPath.wishlistIcon,
      activeIconPath: AssetPath.wishlistFilledIcon,
      label: "Wishlist",
    ),
    DashboardNavItem(
      iconPath: AssetPath.profileIcon,
      activeIconPath: AssetPath.profileFilledIcon,
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: pages[dashboardController.currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kWhite,
          type: BottomNavigationBarType.fixed,
          elevation: 0.5,
          currentIndex: dashboardController.currentIndex,
          onTap: (index) => dashboardController.updateCurrentIndex(index),
          items: navItemsList.map((item) {
            int index = navItemsList.indexOf(item);
            return BottomNavigationBarItem(
              icon: _BottomNavIcon(
                iconPath: item.iconPath,
                isActive: _isActive(index),
              ),
              activeIcon: _BottomNavIcon(
                iconPath: item.activeIconPath,
                isActive: _isActive(index),
              ),
              label: item.label,
              tooltip: item.label,
            );
          }).toList(),
        ),
      );
    });
  }

  bool _isActive(int index) {
    return dashboardController.currentIndex == index;
  }
}

class _BottomNavIcon extends StatelessWidget {
  final String iconPath;
  final bool isActive;

  const _BottomNavIcon({
    required this.iconPath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(
        isActive ? kPrimaryColor : kGrey,
        BlendMode.srcIn,
      ),
      height: 20,
      width: 20,
    );
  }
}