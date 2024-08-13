import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
import 'package:amarsolution_multikart/src/core/widgets/row_text.dart';

class CheckoutAmountsWidget extends StatelessWidget {
  final num subtotal;
  final num shippingFee;
  final num? couponDiscount;
  final VoidCallback onTapAddCoupon;
  final num totalWithDiscount;
  final num grandTotal;

  const CheckoutAmountsWidget({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.couponDiscount,
    required this.onTapAddCoupon,
    required this.totalWithDiscount,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Details:",
            style: context.titleMedium(),
          ),
          const SizedBox(height: 12),
          RowText(
            title: 'Sub Total:',
            value: '${AppConstants.currencySymbol} $subtotal',
            paddingBottom: 2,
            titleStyle: context.appTextTheme.bodySmall,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Coupon Discount:',
                  style: context.appTextTheme.bodySmall,
                ),
              ),
              const SizedBox(width: 5),
              couponDiscount != null
                  ? Expanded(
                      child: Text(
                        '${AppConstants.currencySymbol} $couponDiscount',
                        textAlign: TextAlign.end,
                        style: context.appTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: kRed,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: onTapAddCoupon,
                      style: const ButtonStyle(
                          visualDensity: VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      )),
                      child: Text(
                        'Add',
                        style: context.buttonTextStyle(),
                      ),
                    ),
            ],
          ),
          const KDivider(height: 10),
          RowText(
            title: 'Total with Discount:',
            value: '${AppConstants.currencySymbol} $totalWithDiscount',
            paddingBottom: 8,
            titleStyle: context.appTextTheme.bodySmall,
          ),
          RowText(
            title: 'Shipping Fee:',
            value: '${AppConstants.currencySymbol} $shippingFee',
            titleStyle: context.appTextTheme.bodySmall,
          ),
          const KDivider(height: 10),
          RowText(
            title: 'Grand Total:',
            value: '${AppConstants.currencySymbol} $grandTotal',
            paddingBottom: 8,
            titleStyle: context.appTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
