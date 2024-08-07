import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/app_expansion_tile.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/features/category/controller/category_controller.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';
import 'package:amarsolution_multikart/src/features/category/view/widgets/category_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page_with_search.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Obx(() {
        return categoryController.isCategoryListLoading.value
            ? const CategoryLoadingWidget()
            : categoryController.categoryList.isEmpty
                ? const FailureWidgetBuilder()
                : ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: categoryController.categoryList.length,
                    itemBuilder: (context, index) {
                      return buildCategory(
                        index: index,
                        category: categoryController.categoryList[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                  );
      }),
    );
  }

  Widget buildCategory({
    required int index,
    required CategoryModel category,
  }) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kWhite,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: AppExpansionTile(
            title: Text(
              category.categoryName ?? '',
              style: context.appTextTheme.bodyLarge,
            ),
            trailing: category.childCategories!.isEmpty
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      if (categoryController.selectedCategoryIndex == index) {
                        categoryController.updateCategoryIndex(-1);
                      } else {
                        categoryController.updateCategoryIndex(index);
                      }
                      categoryController.updateSubCategoryIndex(-1);
                    },
                    child: Icon(
                      categoryController.selectedCategoryIndex == index
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 22,
                    ),
                  ),
            childrenPadding: EdgeInsets.zero,
            expandedAlignment: Alignment.centerLeft,
            initiallyExpanded:
                categoryController.selectedCategoryIndex == index,
            children: [
              if (category.childCategories!.isNotEmpty)
                ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: category.childCategories?.length,
                  itemBuilder: (context, subIndex) {
                    return buildSubCategory(
                      index: subIndex,
                      subCategory: category.childCategories![subIndex],
                    );
                  },
                ),
            ],

            ///to select single tile
            onExpansionChanged: (s) {
              Get.to(
                () => ProductPageWithSearch(
                  title: '${category.categoryName}',
                  api: Api.productList,
                  categoryId: '${category.id}',
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget buildSubCategory({
    required int index,
    required CategoryModel subCategory,
  }) {
    return Obx(() {
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
              style: context.appTextTheme.bodyMedium,
            ),
            trailing: subCategory.childCategories!.isEmpty
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      if (categoryController.selectedSubCategoryIndex ==
                          index) {
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
            initiallyExpanded:
                categoryController.selectedSubCategoryIndex == index,
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
                    return buildChildCategory(
                      index: childIndex,
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
    });
  }

  Widget buildChildCategory({
    required int index,
    required CategoryModel childCategory,
  }) {
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
