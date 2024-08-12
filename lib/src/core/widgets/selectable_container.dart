import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class SelectableContainer extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? selectedBgColor;
  final Color? unSelectedBgColor;
  final Color? selectedBorderColor;
  final Color? unSelectedBorderColor;

  const SelectableContainer({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.child,
    this.margin,
    this.height,
    this.width,
    this.borderRadius = 8,
    this.selectedBgColor,
    this.unSelectedBgColor,
    this.selectedBorderColor,
    this.unSelectedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
            color: isSelected
                ? selectedBgColor ?? kPrimaryColor
                : unSelectedBgColor ?? kGreyLight,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isSelected
                  ? selectedBorderColor ?? kPrimaryColor
                  : unSelectedBorderColor ?? kGreyLight,
              width: 1,
            )
        ),
        alignment: Alignment.center,
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}