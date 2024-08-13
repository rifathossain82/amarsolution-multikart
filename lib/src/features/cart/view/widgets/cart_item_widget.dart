import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/increment_decrement_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/cart/model/cart_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel cartItem;
  final CartController cartController;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImageBuilder(
            height: 100,
            width: 100,
            imgURl: cartItem.productImage ?? '',
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.productName ?? '',
                  style: context.appTextTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    if (cartItem.variant != null &&
                        cartItem.variant?.size != null &&
                        cartItem.variant?.color != null &&
                        cartItem.variant?.size?.trim() != "" &&
                        cartItem.variant?.color?.trim() != "")
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 4,
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
                  ],
                ),
                const SizedBox(height: 6),
                cartItem.wholesaleQuantity! > 0 &&
                        cartItem.quantity! >= cartItem.wholesaleQuantity!
                    ? Row(
                        children: [
                          Text(
                            '${AppConstants.currencySymbol} ${cartItem.wholesalePrice}',
                            style: context.appTextTheme.titleSmall?.copyWith(
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
                const SizedBox(height: 8),
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    _BottomIconTextButton(
                      onTap: onMoveWishlist,
                      text: "Move to wishlist",
                      iconPath: AssetPath.wishlistIcon,
                    ),
                    Container(
                      height: 12,
                      width: 1.5,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    _BottomIconTextButton(
                      onTap: onRemoveFromCart,
                      text: "Remove",
                      iconPath: AssetPath.deleteIcon,
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

  void onMoveWishlist(){}
  void onRemoveFromCart(){
    cartController.removedFromCart(
      productId: cartItem.productId,
      variantId: cartItem.variant?.id,
    );

    SnackBarService.showSnackBar(
      message: 'Item Deleted!',
      bgColor: successColor,
    );
  }
}

class _BottomIconTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String iconPath;

  const _BottomIconTextButton({
    required this.onTap,
    required this.text,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 14,
            width: 14,
            alignment: Alignment.center,
            colorFilter: const ColorFilter.mode(kGrey, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: context.appTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: kGrey,
            ),
          ),
        ],
      ),
    );
  }
}
