import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class PriceWidget extends StatelessWidget {
  final num? newPrice;
  final num? oldPrice;
  final num? discountValue;
  final String? discountType;
  final TextStyle? newPriceStyle;

  const PriceWidget({
    super.key,
    required this.newPrice,
    required this.oldPrice,
    required this.discountValue,
    required this.discountType,
    this.newPriceStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${AppConstants.currencySymbol} $newPrice',
          style: newPriceStyle ??
              context.appTextTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
        ),
        if (oldPrice != null && discountValue! > 0)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RichText(
                maxLines: 2,
                softWrap: false,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppConstants.currencySymbol} $oldPrice',
                      style: context.appTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text: '  ${discountType == 'Amount' ? '${AppConstants.currencySymbol}$discountValue' : '$discountValue%'} OFF',
                      style: context.appTextTheme.bodySmall?.copyWith(
                        color: kGreen,
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
