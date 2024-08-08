import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class AccountPageLoadingWidget extends StatelessWidget {
  const AccountPageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 25,
          ),
          child: Row(
            children: [
              const KShimmerContainer(
                height: 60,
                width: 60,
                shape: BoxShape.circle,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KShimmerContainer(
                    height: 30,
                    width: context.screenWidth * 0.6,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 5),
                  KShimmerContainer(
                    height: 27,
                    width: context.screenWidth * 0.4,
                    borderRadius: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: BoxDecoration(
              color: kScaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => const KShimmerContainer(
                borderRadius: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
