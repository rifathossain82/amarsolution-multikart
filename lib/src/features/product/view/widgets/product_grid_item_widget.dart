import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/stock_out_text_widget.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_details_page.dart';

class ProductGridItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductGridItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// when current route is productDetailsPage
        /// and the item is for related products then we need to show clicked items
        /// in the same page, so we call details and relatedProducts api by this current product
        if (Get.currentRoute == '/ProductDetailsPage') {
          Get.find<ProductController>()
            ..getProductDetails(product.slug ?? '')
            ..getRelatedProductList(
              productId: product.id!,
              categoryId: '${product.category?.id}',
            );
        } else {
          Get.to(
            () => ProductDetailsPage(
              product: product,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(color: kWhite),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  CachedNetworkImageBuilder(
                    imgURl: product.image ?? '',
                    borderRadius: BorderRadius.circular(0),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (product.stockQty! < 1)
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: StockOutTextWidget(
                        verticalPadding: 10,
                        verticalBottomRadius: 0,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              height: 84,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    product.productName ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: context.appTextTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  PriceWidget(
                    newPrice: product.newPrice,
                    oldPrice: product.oldPrice,
                    discountValue: product.discountPercentage,
                    discountType: "Percentage",
                    newPriceStyle: context.appTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
