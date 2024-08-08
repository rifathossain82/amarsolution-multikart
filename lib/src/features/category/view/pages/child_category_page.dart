import 'package:amarsolution_multikart/src/features/category/view/widgets/child_category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';

class ChildCategoryPage extends StatefulWidget {
  final CategoryModel parentCategory;
  final CategoryModel subCategory;

  const ChildCategoryPage({
    super.key,
    required this.parentCategory,
    required this.subCategory,
  });

  @override
  State<ChildCategoryPage> createState() => _ChildCategoryPageState();
}

class _ChildCategoryPageState extends State<ChildCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories > ${widget.parentCategory.categoryName} > ${widget.subCategory.categoryName}'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: widget.subCategory.childCategories!.length,
        itemBuilder: (context, index) {
          return ChildCategoryItemWidget(
            index: index,
            childCategory: widget.subCategory.childCategories![index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
