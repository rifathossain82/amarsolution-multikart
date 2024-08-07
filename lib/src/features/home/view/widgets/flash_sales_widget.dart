import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/stock_out_text_widget.dart';
import 'package:amarsolution_multikart/src/features/home/controller/homepage_controller.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/flash_sales_count_down_timer_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_product_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_details_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page.dart';

const double flashSalesItemHeight = 200;
const double flashSalesItemWidth = 160;

class FlashSalesWidget extends StatelessWidget {
  const FlashSalesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homepageController = Get.find<HomepageController>();
    return Obx(() {
      return homepageController.isFlashSalesProductListLoading.value
          ? const HomepageProductLoadingWidget(
              height: flashSalesItemHeight,
              width: flashSalesItemWidth,
            )
          : homepageController.flashSalesProductList.isEmpty
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: kWhite,
                    boxShadow: [
                      KBoxShadow.itemShadow(),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FlashSalesWidgetHeader(
                        onViewAll: () {
                          Get.to(
                            () => ProductPage(
                              title: 'Flash Sales',
                              api: Api.flashSalesProductList,
                              expireTime:
                                  homepageController.flashSalesExpireTime.value,
                            ),
                          );
                        },
                        text: 'Flash Sales',
                        expireTime:
                            homepageController.flashSalesExpireTime.value,
                      ),
                      SizedBox(
                        height: flashSalesItemHeight,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              homepageController.flashSalesProductList.length,
                          itemBuilder: (context, int index) =>
                              _FlashSalesItemWidget(
                            product:
                                homepageController.flashSalesProductList[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                    ],
                  ),
                );
    });
  }
}

class _FlashSalesWidgetHeader extends StatelessWidget {
  final VoidCallback onViewAll;
  final String text;
  final DateTime? expireTime;

  const _FlashSalesWidgetHeader({
    Key? key,
    required this.onViewAll,
    required this.text,
    required this.expireTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 0,
        top: 15,
        bottom: 0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: context.appTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (expireTime != null)
            FlashSalesCountDownTimerWidget(
              expireTime: expireTime!,
            ),
          InkWell(
            onTap: onViewAll,
            borderRadius: BorderRadius.circular(4),
            splashColor: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                children: [
                  Text(
                    'All',
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: context.appTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kGrey,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: kGrey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlashSalesItemWidget extends StatelessWidget {
  final ProductModel product;

  const _FlashSalesItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: flashSalesItemWidth,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ProductDetailsPage(
              product: product,
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImageBuilder(
                  imgURl: product.image ?? '',
                  borderRadius: BorderRadius.circular(8),
                  height: flashSalesItemHeight * 0.6,
                  fit: BoxFit.cover,
                ),
                if (product.stockQty! < 1)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: StockOutTextWidget(
                      verticalPadding: 6,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '${product.productName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.appTextTheme.titleSmall,
            ),
            const SizedBox(height: 3),
            Text(
              '${AppConstants.currencySymbol} ${product.newPrice ?? 0}',
              style: context.appTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
