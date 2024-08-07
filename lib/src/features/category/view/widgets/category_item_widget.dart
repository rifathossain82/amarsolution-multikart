import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';
import 'package:amarsolution_multikart/src/features/category/view/pages/sub_category_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page_with_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemWidget extends StatelessWidget {
  final int index;
  final CategoryModel category;

  const CategoryItemWidget({
    super.key,
    required this.index,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapCategoryItem,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kGreyLight,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.categoryName?.toUpperCase() ?? '',
                    maxLines: 1,
                    style: context.appTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.slug ?? '',
                    maxLines: 1,
                    style: context.appTextTheme.bodySmall,
                  ),
                ],
              ),
            ),
            CachedNetworkImageBuilder(
              imgURl: category.image ?? '',
              borderRadius: BorderRadius.circular(100),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapCategoryItem() {
    if (category.childCategories!.isEmpty) {
      Get.to(
        () => ProductPageWithSearch(
          title: '${category.categoryName}',
          api: Api.productList,
          categoryId: '${category.id}',
        ),
      );
    } else {
      Get.to(
        () => SubCategoryPage(
          parentCategory: category,
        ),
      );
    }
  }
}
