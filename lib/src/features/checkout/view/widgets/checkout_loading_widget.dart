import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class CheckoutLoadingWidget extends StatelessWidget {
  const CheckoutLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            KShimmerContainer(
              height: 150,
              width: context.screenWidth,
              borderRadius: 4,
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  KBoxShadow.itemShadow(),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      KShimmerContainer(
                        height: 30,
                        width: context.screenWidth * 0.4,
                        borderRadius: 4,
                      ),
                      const Spacer(),
                      const KShimmerContainer(
                        height: 30,
                        width: 30,
                        shape: BoxShape.circle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ...List.generate(
                    3,
                    (index) => KShimmerContainer(
                      height: 100,
                      width: context.screenWidth,
                      borderRadius: 4,
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            KShimmerContainer(
              height: 90,
              width: context.screenWidth,
              borderRadius: 4,
            ),
            const SizedBox(height: 15),
            KShimmerContainer(
              height: 120,
              width: context.screenWidth,
              borderRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
