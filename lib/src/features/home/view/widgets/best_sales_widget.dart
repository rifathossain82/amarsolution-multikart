import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/stock_out_text_widget.dart';
import 'package:amarsolution_multikart/src/features/home/controller/homepage_controller.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_title_text_builder.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_details_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page.dart';

import 'homepage_product_loading_widget.dart';

const double bestSalesItemHeight = 260;
const double bestSalesItemWidth = 150;

class BestSalesWidget extends StatelessWidget {
  const BestSalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homepageController = Get.find<HomepageController>();
    return Obx(() {
      return homepageController.isBestSalesProductListLoading.value
          ? const HomepageProductLoadingWidget(
              height: bestSalesItemHeight,
              width: bestSalesItemWidth,
            )
          : homepageController.bestSalesProductList.isEmpty
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: kWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomepageTitleTextBuilder(
                        onViewAll: () {
                          // Get.find<HomepageVideoPlayerController>()
                          //     .pauseVideo();
                          Get.to(
                            () => ProductPage(
                              title: 'Best Sales',
                              api: Api.bestSalesProductList,
                            ),
                          );
                        },
                        text: 'Best Sales',
                      ),
                      SizedBox(
                        height: bestSalesItemHeight,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              homepageController.bestSalesProductList.length,
                          itemBuilder: (context, int index) {
                            return _BestSalesItemWidget(
                              product: homepageController
                                  .bestSalesProductList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                        ),
                      ),
                    ],
                  ),
                );
    });
  }
}

class _BestSalesItemWidget extends StatelessWidget {
  final ProductModel product;

  const _BestSalesItemWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.find<HomepageVideoPlayerController>().pauseVideo();
        Get.to(
          () => ProductDetailsPage(
            product: product,
          ),
        );
      },
      child: SizedBox(
        width: bestSalesItemWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImageBuilder(
                  imgURl: product.image ?? '',
                  borderRadius: BorderRadius.circular(8),
                  height: bestSalesItemHeight * 0.75,
                  width: bestSalesItemWidth,
                  fit: BoxFit.cover,
                ),
                if (product.stockQty! < 1)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: StockOutTextWidget(
                      verticalPadding: 8,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              product.productName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.appTextTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            RichText(
              maxLines: 1,
              softWrap: false,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${AppConstants.currencySymbol}${product.newPrice ?? 0.0}',
                    style: context.appTextTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kBlackLight,
                    ),
                  ),
                  TextSpan(
                    text: '   ${AppConstants.currencySymbol}',
                    style: context.appTextTheme.bodySmall?.copyWith(
                      color: kGrey,
                    ),
                  ),
                  TextSpan(
                    text: '${product.oldPrice ?? 0.0}',
                    style: context.appTextTheme.bodySmall?.copyWith(
                      color: kGrey,
                      decoration: TextDecoration.lineThrough,
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
