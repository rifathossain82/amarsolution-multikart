import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class SliderIndicatorWidget extends StatelessWidget {
  final int length;
  final int currentIndex;

  const SliderIndicatorWidget({super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: context.screenWidth,
      alignment: Alignment.center,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: length,
        itemBuilder: (context, int index) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: currentIndex == index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  currentIndex == index ? 15 : 30,
                ),
                color: currentIndex == index ? kPrimaryColor : kGreyLight,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}