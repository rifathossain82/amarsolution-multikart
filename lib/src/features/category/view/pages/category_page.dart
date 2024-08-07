import 'package:amarsolution_multikart/src/features/category/view/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/features/category/controller/category_controller.dart';
import 'package:amarsolution_multikart/src/features/category/view/widgets/category_loading_widget.dart';

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
                      return CategoryItemWidget(
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
}
