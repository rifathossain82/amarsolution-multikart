import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/radio_list_tile_widget.dart';
import 'package:amarsolution_multikart/src/features/checkout/controller/checkout_controller.dart';
import 'package:amarsolution_multikart/src/features/shop_info/controller/shop_info_controller.dart';
import 'package:amarsolution_multikart/src/features/shop_info/model/payment_method_model.dart';

class CheckoutPaymentMethodWidget extends StatelessWidget {
  final ShopInfoController shopInfoController;
  final CheckoutController checkoutController;

  const CheckoutPaymentMethodWidget({
    super.key,
    required this.shopInfoController,
    required this.checkoutController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (shopInfoController.paymentMethods.value == null) {
        return const SizedBox();
      } else {
        PaymentMethodModel paymentMethods =
            shopInfoController.paymentMethods.value!;
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method (Required)',
                style: context.titleMedium(),
              ),
              const SizedBox(height: 4),
              if (paymentMethods.cashOnDelivery != null &&
                  paymentMethods.cashOnDelivery?.status == 1)
                RadioListTileWidget(
                  title: paymentMethods.cashOnDelivery?.title ?? 'Cash on Delivery',
                  value: paymentMethods.cashOnDelivery?.key,
                  groupValue: checkoutController.selectedPaymentMethodKey.value,
                  onChanged: (value) {
                    checkoutController.updatePaymentMethodKey(
                      paymentMethods.cashOnDelivery!.key!,
                    );
                  },
                ),
              if (paymentMethods.ssl != null && paymentMethods.ssl?.status == 1)
                RadioListTileWidget(
                  title: paymentMethods.ssl?.title ?? 'Online Payment',
                  value: paymentMethods.ssl?.key,
                  groupValue: checkoutController.selectedPaymentMethodKey.value,
                  onChanged: (value) {
                    checkoutController.updatePaymentMethodKey(
                      paymentMethods.ssl!.key!,
                    );
                  },
                ),
            ],
          ),
        );
      }
    });
  }
}
