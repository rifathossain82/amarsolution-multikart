import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page_with_search.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetPath.emptyCart,
            height: context.screenHeight * 0.2,
            width: context.screenWidth,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Whoops!! Cart is ',
                  style: context.appTextTheme.titleLarge?.copyWith(
                    color: kBlackLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Empty!',
                  style: context.appTextTheme.titleLarge?.copyWith(
                    color: kRedDeep,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Text(
              'Looks like you haven’t added anything to your cart yet. You will find a lot of interesting products on our ‘Shop’ page.',
              style: context.bodyMedium(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          KButton(
            onPressed: () {
              Get.to(
                () => ProductPageWithSearch(
                  api: Api.productList,
                  title: "Products",
                ),
              );
            },
            borderRadius: 100,
            width: context.screenWidth * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: kWhite,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Return to Shop',
                  style: context.buttonTextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
