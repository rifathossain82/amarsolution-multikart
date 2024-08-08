import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/increment_decrement_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/cart/model/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel cartItem;
  final CartController cartController;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.cartController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        cartController.removedFromCart(
          productId: cartItem.productId,
          variantId: cartItem.variant?.id,
        );

        SnackBarService.showSnackBar(
          message: 'Item Deleted!',
          bgColor: successColor,
        );
      },
      direction: DismissDirection.horizontal,
      background: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: kRed,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.delete,
          color: kWhite,
        ),
      ),
      child: Container(
        height: 100,
        alignment: Alignment.center,
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
              height: double.maxFinite,
              width: 80,
              imgURl: cartItem.productImage ?? '',
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(4),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.productName ?? '',
                      style: context.appTextTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (cartItem.variant != null &&
                            cartItem.variant?.size != null &&
                            cartItem.variant?.color != null &&
                            cartItem.variant?.size?.trim() != "" &&
                            cartItem.variant?.color?.trim() != "")
                          Container(
                            alignment: Alignment.center,
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
                        IncrementDecrementWidget(
                          value: '${cartItem.quantity}',
                          onIncrement: () {
                            if (cartItem.stock! <= cartItem.quantity!) {
                              SnackBarService.showSnackBar(
                                message: 'No more products!',
                                bgColor: failedColor,
                              );
                            } else {
                              cartItem.quantity = cartItem.quantity! + 1;
                              cartController.addToCart(
                                cartItem,
                              );
                            }
                          },
                          onDecrement: () {
                            if (cartItem.quantity! > 1) {
                              cartItem.quantity = cartItem.quantity! - 1;
                              cartController.addToCart(
                                cartItem,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    cartItem.wholesaleQuantity! > 0 &&
                            cartItem.quantity! >= cartItem.wholesaleQuantity!
                        ? Row(
                            children: [
                              Text(
                                '${AppConstants.currencySymbol} ${cartItem.wholesalePrice}',
                                style:
                                    context.appTextTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(Wholesale)',
                                style: context.appTextTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          )
                        : PriceWidget(
                            newPrice: cartItem.discountSellingPrice,
                            oldPrice: cartItem.sellingPrice,
                            discountValue: cartItem.discountValue,
                            discountType: cartItem.discountType,
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
