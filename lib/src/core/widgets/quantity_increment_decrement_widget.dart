import 'package:flutter/cupertino.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class QuantityIncrementDecrementWidget extends StatelessWidget {
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final num quantity;
  final double? height;
  final double? width;

  const QuantityIncrementDecrementWidget({
    Key? key,
    required this.onDecrement,
    required this.onIncrement,
    required this.quantity,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 35,
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kWhite,
        border: Border.all(
          color: kPrimaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: const Icon(
              CupertinoIcons.minus,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$quantity',
            style: context.appTextTheme.bodySmall?.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onIncrement,
            child: const Icon(
              CupertinoIcons.plus,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
