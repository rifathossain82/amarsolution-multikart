import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';

class GridViewWidgetBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double baseItemWidth;
  final int crossAxisCount;
  final bool isScrollable;
  final Color? bgColor;

  const GridViewWidgetBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(0),
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.baseItemWidth = 100,
    this.crossAxisCount = 2,
    this.isScrollable = true,
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: MasonryGridView.count(
        padding: padding,
        shrinkWrap: isScrollable ? false : true,
        physics: isScrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        crossAxisCount: crossAxisCount,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}