import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_widget.dart';

class HomepageCategoryTabWidget extends StatefulWidget {
  final String categoryId;

  const HomepageCategoryTabWidget({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<HomepageCategoryTabWidget> createState() => _HomepageCategoryTabWidgetState();
}

class _HomepageCategoryTabWidgetState extends State<HomepageCategoryTabWidget> {
  final productController = Get.find<ProductController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getProducts(reload: true);
    scrollIndicator();
    super.initState();
  }

  void getProducts({bool reload = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productController.getProductList(
        api: Api.productList,
        categoryIds: [widget.categoryId],
        reload: reload,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollIndicator() {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          kPrint('reach to bottom');
          if (!productController.loadedCompleted.value) {
            ++productController.pageNumber.value;
            getProducts();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return productController.isProductListLoading.value
          ? const ProductsLoadingWidget(viewType: ProductsViewType.list)
          : productController.productList.isEmpty
              ? const FailureWidgetBuilder()
              : ProductsWidget(
                  viewType: ProductsViewType.list,
                  controller: _scrollController,
                  productList: productController.productList,
                  loadedComplete: productController.loadedCompleted.value,
                );
    });
  }
}
