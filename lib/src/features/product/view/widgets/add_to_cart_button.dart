import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddToCartButton({
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
          color: kPrimaryColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          'Add to Cart',
          style: context.appTextTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}