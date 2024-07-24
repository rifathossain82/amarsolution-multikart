import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class KCardWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final TextStyle? titleStyle;
  final double? width;
  final bool centerTitle;

  const KCardWidget({
    super.key,
    required this.child,
    required this.title,
    this.titleStyle,
    this.width,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      width: width ?? context.screenWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width ?? context.screenWidth,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: kGrey,
                width: 1,
              ),
            ),
            child: child,
          ),
          Positioned(
            top: 0,
            left: centerTitle ? 0 : 10,
            right: 0,
            child: Container(
              color: Colors.transparent,
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Container(
                color: kWhite,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  style: titleStyle ?? context.appTextTheme.titleSmall?.copyWith(
                    color: kGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
