import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/app_expansion_tile.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/features/cart/model/cart_model.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/widgets/checkout_product_item_widget.dart';

class CheckoutProductsWidget extends StatelessWidget {
  final List<CartModel> cartList;
  final num totalAmount;
  final int tileIndex;
  final ValueChanged<bool> onExpansionChanged;

  const CheckoutProductsWidget({
    Key? key,
    required this.cartList,
    required this.totalAmount,
    required this.tileIndex,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          KBoxShadow.itemShadow(),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: AppExpansionTile(
          title: Text(
            'Products',
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            tileIndex == 1
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            size: 20,
          ),
          childrenPadding: const EdgeInsets.all(10),
          tilePadding: EdgeInsets.zero,
          expandedAlignment: Alignment.centerLeft,
          initiallyExpanded: tileIndex == 1,

          ///to select single tile
          onExpansionChanged: onExpansionChanged,
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return CheckoutProductItemWidget(
                  cartItem: cartList[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total:   ',
                      style: context.appTextTheme.titleSmall,
                    ),
                    TextSpan(
                      text: '${AppConstants.currencySymbol} $totalAmount',
                      style: context.appTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
