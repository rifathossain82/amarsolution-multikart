import 'package:amarsolution_multikart/src/features/category/view/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';

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
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: widget.parentCategory.childCategories!.length,
        itemBuilder: (context, index) {
          return CategoryItemWidget(
            index: index,
            category: widget.parentCategory.childCategories![index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
