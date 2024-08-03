import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class CategoryLoadingWidget extends StatelessWidget {
  const CategoryLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const KShimmerContainer(
          height: 60,
          width: double.maxFinite,
          borderRadius: 8,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
