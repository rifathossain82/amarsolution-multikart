import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomIconTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String iconPath;
  final Color color;

  const BottomIconTextButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.iconPath,
    this.color = kBlackLight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 20,
            width: 20,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          Text(
            text.toUpperCase(),
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
