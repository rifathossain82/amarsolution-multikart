import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/best_sales_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/flash_sales_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_category_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/new_arrival_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/slider_widget.dart';

class HomepageAllWidget extends StatelessWidget {
  const HomepageAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: const [
        SliderWidget(),
        NewArrivalWidget(),
        FlashSalesWidget(),
        BestSalesWidget(),
        HomepageCategoryWidget(),
      ],
    );
  }
}

