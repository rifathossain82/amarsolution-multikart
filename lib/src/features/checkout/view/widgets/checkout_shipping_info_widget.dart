import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/features/checkout/controller/checkout_controller.dart';

class CheckoutShippingInfoWidget extends StatelessWidget {
  final CheckoutController checkoutController;
  final VoidCallback onTapPhoneNumber;
  final VoidCallback onTapShippingInfo;

  const CheckoutShippingInfoWidget({
    Key? key,
    required this.checkoutController,
    required this.onTapPhoneNumber,
    required this.onTapShippingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            KBoxShadow.itemShadow(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Information',
              style: context.appTextTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              visualDensity: VisualDensity.comfortable,
              leading: Icon(
                Icons.phone,
                size: 18,
                color: kBlackLight,
              ),
              title: Text(
                checkoutController.phoneNumber.value.isEmpty
                    ? 'Enter phone number'
                    : checkoutController.phoneNumber.value,
                style: context.appTextTheme.titleSmall,
              ),
              trailing:
                  LocalStorage.getData(key: LocalStorageKey.isGuestCheckout) ==
                          true
                      ? IconButton(
                          onPressed: onTapPhoneNumber,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: kBlackLight,
                          ),
                        )
                      : const SizedBox.shrink(),
            ),
            const Divider(height: 0),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              visualDensity: VisualDensity.comfortable,
              leading: Icon(
                Icons.local_shipping,
                size: 18,
                color: kBlackLight,
              ),
              title: Text(
                checkoutController.userName.value.isEmpty
                    ? 'Please set your name.'
                    : checkoutController.userName.value,
                style: context.appTextTheme.titleSmall,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    checkoutController.addressLine.value.isEmpty &&
                            checkoutController.city.value.isEmpty
                        ? 'Please set your address.'
                        : '${checkoutController.addressLine.value}, ${checkoutController.city.value}',
                  ),
                  Text(
                    checkoutController.isShippingInsideDhaka.value
                        ? 'Inside Dhaka'
                        : 'Outside Dhaka',
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: onTapShippingInfo,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: kBlackLight,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
