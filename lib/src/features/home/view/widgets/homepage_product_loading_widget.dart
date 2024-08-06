import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class HomepageProductLoadingWidget extends StatelessWidget {
  final double height;
  final double width;

  const HomepageProductLoadingWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: kWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KShimmerContainer(
                  height: 20,
                  width: context.screenWidth * 0.4,
                  borderRadius: 4,
                ),
                const KShimmerContainer(
                  height: 20,
                  width: 60,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, int index) => Column(
                children: [
                  KShimmerContainer(
                    height: height * 0.65,
                    width: width,
                    borderRadius: 8,
                  ),
                  const SizedBox(height: 5),
                  KShimmerContainer(
                    height: 20,
                    width: width,
                    borderRadius: 8,
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
            ),
          ),
        ],
      ),
    );
  }
}
