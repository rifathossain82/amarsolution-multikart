import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/stock_out_text_widget.dart';
import 'package:amarsolution_multikart/src/features/home/controller/homepage_controller.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_product_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_title_text_builder.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_details_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page.dart';

const double newArrivalItemHeight = 180;
const double newArrivalItemWidth = 100;

class NewArrivalWidget extends StatelessWidget {
  const NewArrivalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homepageController = Get.find<HomepageController>();
    return Obx(() {
      return homepageController.isNewArrivalProductListLoading.value
          ? const HomepageProductLoadingWidget(
              height: newArrivalItemHeight,
              width: newArrivalItemWidth,
            )
          : homepageController.newArrivalProductList.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: const BoxDecoration(
                    color: kWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomepageTitleTextBuilder(
                        onViewAll: () {
                          Get.to(
                            () => ProductPage(
                              title: 'New Arrival',
                              api: Api.newArrivalProductList,
                            ),
                          );
                        },
                        text: 'New Arrival',
                      ),
                      SizedBox(
                        height: newArrivalItemHeight,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              homepageController.newArrivalProductList.length,
                          itemBuilder: (context, int index) =>
                              _NewArrivalItemWidget(
                            product:
                                homepageController.newArrivalProductList[index],
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

class _NewArrivalItemWidget extends StatelessWidget {
  final ProductModel product;

  const _NewArrivalItemWidget({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: newArrivalItemWidth,
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ProductDetailsPage(
              product: product,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImageBuilder(
                  imgURl: product.image ?? '',
                  borderRadius: BorderRadius.circular(8),
                  height: newArrivalItemHeight * 0.65,
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
                    text: '${AppConstants.currencySymbol}${product.newPrice ?? 0.0}',
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
