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

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetPath.wishlistIcon,
            height: context.screenHeight * 0.12,
            width: context.screenWidth,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your Wishlist is ',
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
              'Explore more and shortlist some items',
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
                const Icon(
                  Icons.add,
                  color: kWhite,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Add New Wish',
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
