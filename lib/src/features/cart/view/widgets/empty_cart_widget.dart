import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          // SvgPicture.asset(
          //   AssetPath.emptyCartIcon,
          //   height: context.screenHeight * 0.27,
          //   width: context.screenWidth,
          //   alignment: Alignment.center,
          // ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your Cart is ',
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
              'Must add items on the cart before you proceed to check out.',
              style: context.appTextTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          KButton(
            onPressed: () {
              Get.to(
                () => ProductPageWithSearch(
                  api: Api.productList,
                ),
              );
            },
            borderRadius: 100,
            width: context.screenWidth * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
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
