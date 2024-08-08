import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/loading_overlay.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/wishlist/controller/wishlist_controller.dart';

class WishlistItemWidget extends StatelessWidget {
  final ProductModel product;
  final WishlistController wishlistController;

  const WishlistItemWidget({
    Key? key,
    required this.product,
    required this.wishlistController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        LoadingOverlay.runAsyncTask(context, () async {
          await wishlistController.deleteWishlistItem(
            productId: product.id!,
          );
        });
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
              imgURl: product.image ?? '',
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
                      product.productName ?? '',
                      style: context.appTextTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    PriceWidget(
                      newPrice: product.newPrice,
                      oldPrice: product.oldPrice,
                      discountValue: product.discountPercentage,
                      discountType: "Percentage",
                    ),
                    const SizedBox(height: 2),
                    if (product.stockQty! < 1)
                      Text(
                        'Stock Out',
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: kDeepOrange,
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
