import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class KElevatedButton extends StatelessWidget {
  const KElevatedButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.bgColor,
    this.height,
    this.width,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? borderRadius;
  final Color? bgColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
        backgroundColor: bgColor ?? kPrimaryColor,
        minimumSize: Size(width ?? context.screenWidth, height ?? 42),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        elevation: 0,
      ),
      child: child,
    );
  }
}
