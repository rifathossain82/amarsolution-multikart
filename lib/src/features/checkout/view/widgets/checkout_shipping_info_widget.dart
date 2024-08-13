import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/checkout/controller/checkout_controller.dart';

class CheckoutShippingInfoWidget extends StatelessWidget {
  final CheckoutController checkoutController;
  final VoidCallback onTapPhoneNumber;
  final VoidCallback onTapShippingInfo;

  const CheckoutShippingInfoWidget({
    super.key,
    required this.checkoutController,
    required this.onTapPhoneNumber,
    required this.onTapShippingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(8),
        color: kWhite,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.01),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: kPrimaryColor,
              width: 1,
            ),
          ),
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: const Icon(
              Icons.local_shipping,
              size: 30,
              color: kPrimaryColor,
            ),
            title: Text(
              checkoutController.userName.value.isEmpty
                  ? 'Please set your name.'
                  : checkoutController.userName.value,
              style: context.titleMedium(
                color: kPrimaryColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  checkoutController.phoneNumber.value.isEmpty
                      ? 'Enter phone number'
                      : checkoutController.phoneNumber.value,
                  style: context.bodyLarge(color: kPrimaryColor),
                ),
                const SizedBox(height: 6),
                Text(
                  checkoutController.addressLine.value.isEmpty &&
                          checkoutController.city.value.isEmpty
                      ? 'Please set your address.'
                      : '${checkoutController.addressLine.value}, ${checkoutController.city.value}',
                  style: context.bodyMedium(),
                ),
                Text(
                  checkoutController.isShippingInsideDhaka.value
                      ? 'Inside Dhaka'
                      : 'Outside Dhaka',
                  style: context.bodyMedium(),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: onTapShippingInfo,
              icon: SvgPicture.asset(
                AssetPath.editIcon,
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
