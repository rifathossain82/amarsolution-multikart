import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          AssetPath.filterIcon,
          alignment: Alignment.center,
          colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
        ),
      ),
    );
  }
}
