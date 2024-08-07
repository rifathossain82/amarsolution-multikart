import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class StockOutTextWidget extends StatelessWidget {
  final double verticalPadding;
  final double verticalBottomRadius;

  const StockOutTextWidget({
    super.key,
    this.verticalPadding = 4,
    this.verticalBottomRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: kWhite.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(verticalBottomRadius),
        ),
      ),
      child: Text(
        'Stock Out',
        style: context.appTextTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: kDeepOrange,
        ),
      ),
    );
  }
}
