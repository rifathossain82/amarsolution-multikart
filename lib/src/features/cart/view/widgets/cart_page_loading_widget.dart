import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class CartPageLoadingWidget extends StatelessWidget {
  const CartPageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (context, index) => KShimmerContainer(
        height: 100,
        width: context.screenWidth,
        borderRadius: 4,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
