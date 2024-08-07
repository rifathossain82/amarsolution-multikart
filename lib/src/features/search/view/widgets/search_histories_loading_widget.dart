import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class SearchHistoriesLoadingWidget extends StatelessWidget {
  const SearchHistoriesLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: 10,
      itemBuilder: (context, index) => KShimmerContainer(
        height: 50,
        width: context.screenWidth,
        borderRadius: 4,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
