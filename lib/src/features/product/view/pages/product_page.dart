import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/flash_sales_count_down_timer_widget.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_widget.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final String api;
  final DateTime? expireTime;

  const ProductPage({
    Key? key,
    required this.title,
    required this.api,
    this.expireTime,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productController = Get.find<ProductController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getProducts(reload: true);
    scrollIndicator();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getProducts({bool reload = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productController.getProductList(
        api: widget.api,
        reload: reload,
      );
    });
  }

  void scrollIndicator({bool reload = false}) {
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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4,
        title: Row(
          children: [
            Text(
              widget.title,
              maxLines: 1,
            ),
            const Spacer(),
            if (widget.expireTime != null)
              FlashSalesCountDownTimerWidget(expireTime: widget.expireTime!),
          ],
        ),
      ),
      body: Obx(() {
        return productController.isProductListLoading.value
            ? const ProductsLoadingWidget(viewType: ProductsViewType.grid)
            : productController.productList.isEmpty
                ? const FailureWidgetBuilder()
                : ProductsWidget(
                    viewType: ProductsViewType.grid,
                    controller: _scrollController,
                    productList: productController.productList,
                    loadedComplete: productController.loadedCompleted.value,
                  );
      }),
    );
  }
}
