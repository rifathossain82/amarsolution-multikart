import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartIconWidget extends StatelessWidget {
  final num quantity;
  final VoidCallback onTap;

  const CartIconWidget({
    super.key,
    required this.quantity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: Text(
                '$quantity',
                style: context.appTextTheme.bodySmall?.copyWith(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
