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
import 'package:amarsolution_multikart/src/features/home/model/homepage_category_model.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_title_text_builder.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_details_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page_with_search.dart';

import 'homepage_product_loading_widget.dart';

const double categoryItemHeight = 280;
const double categoryItemWidth = 150;

class HomepageCategoryWidget extends StatelessWidget {
  const HomepageCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homepageController = Get.find<HomepageController>();
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Obx(() {
          return homepageController.isHomepageCategoryListLoading.value
              ? const _HomepageCategoryLoadingWidget()
              : homepageController.homepageCategoryList.isEmpty
                  ? const SizedBox()
                  : _HomepageCategoryList(
                      homepageCategoryList:
                          homepageController.homepageCategoryList,
                    );
        }),
      ],
    );
  }
}

class _HomepageCategoryLoadingWidget extends StatelessWidget {
  const _HomepageCategoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) => const HomepageProductLoadingWidget(
        height: categoryItemHeight,
        width: categoryItemWidth,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}

class _HomepageCategoryList extends StatelessWidget {
  final List<HomepageCategoryModel> homepageCategoryList;

  const _HomepageCategoryList({
    super.key,
    required this.homepageCategoryList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: homepageCategoryList.length,
      itemBuilder: (context, index) => _CategoryItemWidget(
        homepageCategory: homepageCategoryList[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}

class _CategoryItemWidget extends StatelessWidget {
  final HomepageCategoryModel homepageCategory;

  const _CategoryItemWidget({
    super.key,
    required this.homepageCategory,
  });

  @override
  Widget build(BuildContext context) {
    return homepageCategory.products!.isEmpty
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
                HomepageTitleTextBuilder(
                  onViewAll: () {
                    Get.to(
                      () => ProductPageWithSearch(
                        title: homepageCategory.category?.categoryName ?? '',
                        api: Api.productList,
                        categoryId: '${homepageCategory.category?.id}',
                      ),
                    );
                  },
                  text: homepageCategory.category?.categoryName ?? '',
                ),
                SizedBox(
                  height: categoryItemHeight,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: homepageCategory.products!.length,
                    itemBuilder: (context, int index) {
                      return _CategoryProductItemWidget(
                        product: homepageCategory.products![index],
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
  }
}

class _CategoryProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const _CategoryProductItemWidget({super.key, required this.product});

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
      child: SizedBox(
        width: categoryItemWidth,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImageBuilder(
                  imgURl: product.image ?? '',
                  borderRadius: BorderRadius.circular(8),
                  height: categoryItemHeight * 0.7,
                  width: categoryItemWidth,
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
            Text(
              '${AppConstants.currencySymbol} ${product.newPrice}',
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
