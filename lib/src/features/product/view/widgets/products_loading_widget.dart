import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/bottom_loader.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_grid_item_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_list_item_widget.dart';

class ProductsLoadingWidget extends StatelessWidget {
  final ProductsViewType viewType;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  const ProductsLoadingWidget({
    super.key,
    required this.viewType,
    this.shrinkWrap = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return viewType == ProductsViewType.list
        ? _productListLoadingWidget()
        : _productGridLoadingWidget();
  }

  Widget _productListLoadingWidget() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: 20,
      itemBuilder: (context, index) {
        return const KShimmerContainer(
          height: 100,
          width: double.maxFinite,
          borderRadius: 8,
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 10),
    );
  }

  Widget _productGridLoadingWidget() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
      itemCount: 20,
      itemBuilder: (context, index) {
        return KShimmerContainer(
          borderRadius: 8,
          height: context.screenHeight * 0.5,
        );
      },
    );
  }
}
