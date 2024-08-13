import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class AuthCircleShape extends StatelessWidget {
  const AuthCircleShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -context.screenWidth * 0.6,
      right: -context.screenWidth * 0.45,
      child: Container(
        height: context.screenWidth,
        width: context.screenWidth,
        decoration: const BoxDecoration(
          color: kGreyLight,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
