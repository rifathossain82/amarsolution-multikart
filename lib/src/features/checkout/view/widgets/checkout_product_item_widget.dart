import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/model/cart_model.dart';

class CheckoutProductItemWidget extends StatelessWidget {
  final CartModel cartItem;

  const CheckoutProductItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          KBoxShadow.itemShadow(),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImageBuilder(
            height: 80,
            width: 80,
            imgURl: cartItem.productImage ?? '',
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.productName ?? '',
                  style: context.appTextTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (cartItem.variant != null &&
                    cartItem.variant?.size != null &&
                    cartItem.variant?.color != null &&
                    cartItem.variant?.size?.trim() != "" &&
                    cartItem.variant?.color?.trim() != "")
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: kGreyLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${cartItem.variant?.size ?? ''}, ${cartItem.variant?.color ?? ''}',
                      style: context.appTextTheme.bodySmall,
                    ),
                  ),
                const Spacer(),
                Row(
                  children: [
                    cartItem.wholesaleQuantity! > 0 &&
                            cartItem.quantity! >= cartItem.wholesaleQuantity!
                        ? Expanded(
                            child: Row(
                              children: [
                                Text(
                                  '${AppConstants.currencySymbol} ${cartItem.wholesalePrice}',
                                  style: context.appTextTheme.titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(Wholesale)',
                                  style: context.appTextTheme.bodySmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: PriceWidget(
                              newPrice: cartItem.discountSellingPrice,
                              oldPrice: cartItem.sellingPrice,
                              discountValue: cartItem.discountValue,
                              discountType: cartItem.discountType,
                            ),
                          ),
                    Text(
                      'x ${cartItem.quantity}',
                      style: context.appTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kBlackLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
