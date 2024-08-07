import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/widgets/bottom_loader.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_grid_item_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_list_item_widget.dart';

class ProductsWidget extends StatelessWidget {
  final List<ProductModel> productList;
  final bool loadedComplete;
  final ProductsViewType viewType;
  final ScrollController? controller;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  const ProductsWidget({
    Key? key,
    required this.productList,
    required this.loadedComplete,
    required this.viewType,
    this.controller,
    this.shrinkWrap = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viewType == ProductsViewType.list
        ? _productListWidget()
        : _productGridWidget();
  }

  Widget _productListWidget() {
    return ListView.separated(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: loadedComplete ? productList.length : productList.length + 1,
      itemBuilder: (context, index) {
        if (index == productList.length && !loadedComplete) {
          return const BottomLoader();
        } else if (index == productList.length && loadedComplete) {
          return Container();
        }

        return ProductListItemWidget(product: productList[index]);
      },
      separatorBuilder: (context, index) => const Divider(height: 0),
    );
  }

  Widget _productGridWidget() {
    return GridView.builder(
      controller: controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 1/2,
      ),
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: loadedComplete ? productList.length : productList.length + 1,
      itemBuilder: (context, index) {
        if (index == productList.length && !loadedComplete) {
          return const BottomLoader();
        } else if (index == productList.length && loadedComplete) {
          return Container();
        }

        return ProductGridItemWidget(
          product: productList[index],
        );
      },
    );
  }
}
