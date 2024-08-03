import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';

class ProfilePageLoadingWidget extends StatelessWidget {
  const ProfilePageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const KShimmerContainer(
              height: 115,
              width: 115,
              shape: BoxShape.circle,
            ),
            const SizedBox(height: 20),
            ...List.generate(
              8,
              (index) => const _FieldLoadingWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLoadingWidget extends StatelessWidget {
  const _FieldLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KShimmerContainer(
          height: 20,
          width: context.screenWidth * 0.3,
          borderRadius: 4,
        ),
        const SizedBox(height: 5),
        KShimmerContainer(
          height: 40,
          width: context.screenWidth,
          borderRadius: 4,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
