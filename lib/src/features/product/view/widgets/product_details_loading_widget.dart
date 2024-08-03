import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class ProductDetailsLoadingWidget extends StatelessWidget {
  const ProductDetailsLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          KShimmerContainer(
            height: context.screenHeight * 0.5,
            width: context.screenWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KShimmerContainer(
                      height: 20,
                      width: context.screenWidth * 0.4,
                    ),
                    const KShimmerContainer(
                      height: 20,
                      width: 20,
                      borderRadius: 4,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                KShimmerContainer(
                  height: 20,
                  width: context.screenWidth,
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  8,
                      (index) => KShimmerContainer(
                    height: 8,
                    width: index == 7 ? context.screenWidth * 0.5 : context.screenWidth,
                    margin: const EdgeInsets.only(bottom: 2),
                  ),
                ),
                const SizedBox(height: 8),
                KShimmerContainer(
                  height: 100,
                  width: context.screenWidth,
                ),
                const SizedBox(height: 8),
                KShimmerContainer(
                  height: 150,
                  width: context.screenWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
