import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<DashboardController>().updateCurrentIndex(2);
        Get.offAllNamed(RouteGenerator.dashboard);
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            AssetPath.cartIcon,
            colorFilter: const ColorFilter.mode(kBlackLight, BlendMode.srcIn),
            height: 20,
            width: 20,
          ),
          Positioned(
            top: 8,
            right: -8,
            child: Container(
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Obx(() {
                return Text(
                  '${Get.find<CartController>().totalCartItems}',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
