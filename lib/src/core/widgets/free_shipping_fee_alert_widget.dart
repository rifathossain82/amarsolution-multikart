import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class FreeShippingFeeAlertWidget extends StatelessWidget {
  final num freeShippingFeeLimit;

  const FreeShippingFeeAlertWidget({
    super.key,
    required this.freeShippingFeeLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Order above ',
              style: context.appTextTheme.bodySmall?.copyWith(

              ),
            ),
            TextSpan(
              text: '${AppConstants.currencySymbol} $freeShippingFeeLimit ',
              style: context.appTextTheme.bodySmall?.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' to get free shipping!',
              style: context.appTextTheme.bodySmall?.copyWith(

              ),
            ),
          ],
        ),
      ),
    );
  }
}
