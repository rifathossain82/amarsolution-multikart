import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/app_expansion_tile.dart';
import 'package:amarsolution_multikart/src/features/category/controller/category_controller.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';
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
    final categoryController = Get.find<CategoryController>();

    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: AppExpansionTile(
          title: Text(
            subCategory.categoryName ?? '',
            style: context.appTextTheme.titleMedium,
          ),
          trailing: subCategory.childCategories!.isEmpty
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    if (categoryController.selectedSubCategoryIndex == index) {
                      categoryController.updateSubCategoryIndex(-1);
                    } else {
                      categoryController.updateSubCategoryIndex(index);
                    }
                  },
                  child: Icon(
                    categoryController.selectedSubCategoryIndex == index
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                  ),
                ),
          childrenPadding: EdgeInsets.zero,
          expandedAlignment: Alignment.centerLeft,
          initiallyExpanded: categoryController.selectedSubCategoryIndex == index,
          children: [
            if (subCategory.childCategories!.isNotEmpty)
              ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subCategory.childCategories?.length,
                itemBuilder: (context, childIndex) {
                  return _ChildCategoryItemWidget(
                    childCategory: subCategory.childCategories![childIndex],
                  );
                },
              ),
          ],

          ///to select single tile
          onExpansionChanged: (s) {
            Get.to(
              () => ProductPageWithSearch(
                title: '${subCategory.categoryName}',
                api: Api.productList,
                categoryId: '${subCategory.id}',
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ChildCategoryItemWidget extends StatelessWidget {
  final CategoryModel childCategory;

  const _ChildCategoryItemWidget({
    required this.childCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
          () => ProductPageWithSearch(
            title: childCategory.categoryName ?? '',
            api: Api.productList,
            categoryId: '${childCategory.id}',
          ),
        );
      },
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        childCategory.categoryName ?? '',
        style: context.appTextTheme.bodySmall,
      ),
    );
  }
}
