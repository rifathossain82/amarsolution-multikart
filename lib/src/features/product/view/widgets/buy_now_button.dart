import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class BuyNowButton extends StatelessWidget {
  final VoidCallback onTap;

  const BuyNowButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: kDeepOrange,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          'Buy Now',
          style: context.appTextTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
