import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/stock_out_text_widget.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_details_page.dart';

class ProductListItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductListItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductDetailsPage(
            product: product,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImageBuilder(
                      imgURl: product.image ?? '',
                      borderRadius: BorderRadius.circular(8),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    if (product.stockQty! < 1)
                      const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: StockOutTextWidget(),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.appTextTheme.titleSmall,
                      ),
                      const SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
