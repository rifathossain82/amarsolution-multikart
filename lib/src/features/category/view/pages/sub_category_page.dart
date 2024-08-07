import 'package:amarsolution_multikart/src/features/category/view/widgets/category_item_widget.dart';
import 'package:amarsolution_multikart/src/features/category/view/widgets/sub_category_item_widget.dart';
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

class SubCategoryPage extends StatefulWidget {
  final CategoryModel parentCategory;

  const SubCategoryPage({
    super.key,
    required this.parentCategory,
  });

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories > ${widget.parentCategory.categoryName}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: CategoryItemWidget(
              index: 0,
              category: widget.parentCategory,
            ),
          ),
          _ChildCategoryList(
            childCategories: widget.parentCategory.childCategories ?? [],
          )
        ],
      ),
    );
  }

  Widget buildCategory({
    required int index,
    required CategoryModel category,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kWhite,
      ),
      // child: Theme(
      //   data: Theme.of(context).copyWith(
      //     dividerColor: Colors.transparent,
      //   ),
      //   child: AppExpansionTile(
      //     title: Text(
      //       category.categoryName ?? '',
      //       style: context.appTextTheme.bodyLarge,
      //     ),
      //     // trailing: category.childCategories!.isEmpty
      //     //     ? const SizedBox()
      //     //     : GestureDetector(
      //     //         onTap: () {
      //     //           if (categoryController.selectedCategoryIndex == index) {
      //     //             categoryController.updateCategoryIndex(-1);
      //     //           } else {
      //     //             categoryController.updateCategoryIndex(index);
      //     //           }
      //     //           categoryController.updateSubCategoryIndex(-1);
      //     //         },
      //     //         child: Icon(
      //     //           categoryController.selectedCategoryIndex == index
      //     //               ? Icons.keyboard_arrow_up
      //     //               : Icons.keyboard_arrow_down,
      //     //           size: 22,
      //     //         ),
      //     //       ),
      //     childrenPadding: EdgeInsets.zero,
      //     expandedAlignment: Alignment.centerLeft,
      //     // initiallyExpanded: categoryController.selectedCategoryIndex == index,
      //     children: [
      //       if (category.childCategories!.isNotEmpty)
      //         ListView.builder(
      //           padding: const EdgeInsets.symmetric(
      //             horizontal: 15,
      //           ),
      //           physics: const NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemCount: category.childCategories?.length,
      //           itemBuilder: (context, subIndex) {
      //             return buildSubCategory(
      //               index: subIndex,
      //               subCategory: category.childCategories![subIndex],
      //             );
      //           },
      //         ),
      //     ],
      //
      //     ///to select single tile
      //     onExpansionChanged: (s) {
      //       Get.to(
      //         () => ProductPageWithSearch(
      //           title: '${category.categoryName}',
      //           api: Api.productList,
      //           categoryId: '${category.id}',
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

class _ChildCategoryList extends StatelessWidget {
  final List<CategoryModel> childCategories;

  const _ChildCategoryList({
    required this.childCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: childCategories.length,
        itemBuilder: (context, index) {
          return SubCategoryItemWidget(
            index: index,
            subCategory: childCategories[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
