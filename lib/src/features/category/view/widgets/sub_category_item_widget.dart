import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';
import 'package:amarsolution_multikart/src/features/category/view/pages/child_category_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page_with_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryItemWidget extends StatelessWidget {
  final int index;
  final CategoryModel subCategory;

  const SubCategoryItemWidget({
    super.key,
    required this.index,
    required this.subCategory,
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
                    subCategory.categoryName?.toUpperCase() ?? '',
                    maxLines: 1,
                    style: context.appTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subCategory.slug ?? '',
                    maxLines: 1,
                    style: context.appTextTheme.bodySmall,
                  ),
                ],
              ),
            ),
            CachedNetworkImageBuilder(
              imgURl: subCategory.image ?? '',
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
    if (subCategory.childCategories == null || subCategory.childCategories!.isEmpty) {
      Get.to(
        () => ProductPageWithSearch(
          title: '${subCategory.categoryName}',
          api: Api.productList,
          categoryId: '${subCategory.id}',
        ),
      );
    } else {
      Get.to(
        () => ChildCategoryPage(
          parentCategory: subCategory,
          subCategory: subCategory.childCategories![index],
        ),
      );
    }
  }
}
