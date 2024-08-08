import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/free_shipping_fee_alert_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_elevated_button.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/cart/view/widgets/cart_item_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/view/widgets/cart_page_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/view/widgets/empty_cart_widget.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/pages/checkout_page.dart';
import 'package:amarsolution_multikart/src/features/shop_info/controller/shop_info_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.find<CartController>();
  final shopInfoController = Get.find<ShopInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
      ),
      // body: Obx(() {
      //   return shopInfoController.isShopInfoLoading.value
      //       ? const CartPageLoadingWidget()
      //       : shopInfoController.shopInfo.value == null
      //           ? const FailureWidgetBuilder(
      //               title: 'Shop Information is Empty!',
      //             )
      //           : cartController.cartList.isEmpty
      //               ? const EmptyCartWidget()
      //               : _buildCartPageBody();
      // }),
    );
  }

  // Widget _buildCartPageBody() {
  //   final shopInfo = shopInfoController.shopInfo.value;
  //   return Column(
  //     children: [
  //       Expanded(
  //         flex: 9,
  //         child: Column(
  //           children: [
  //             if (shopInfo?.freeDeliveryChargesLimit != null &&
  //                 shopInfo!.freeDeliveryChargesLimit! > 0)
  //               FreeShippingFeeAlertWidget(
  //                 freeShippingFeeLimit: shopInfo.freeDeliveryChargesLimit ?? 0,
  //               ),
  //             Expanded(
  //               child: ListView.separated(
  //                 padding: const EdgeInsets.all(8),
  //                 itemCount: cartController.cartList.length,
  //                 itemBuilder: (context, index) => CartItemWidget(
  //                   cartItem: cartController.cartList[index],
  //                   cartController: cartController,
  //                 ),
  //                 separatorBuilder: (context, index) =>
  //                     const SizedBox(height: 10),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: Container(
  //           width: context.screenWidth,
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 15,
  //           ),
  //           decoration: BoxDecoration(
  //             color: kWhite,
  //             boxShadow: [
  //               KBoxShadow.itemShadow(),
  //             ],
  //           ),
  //           child: Row(
  //             children: [
  //               Text(
  //                 'Total',
  //                 style: context.appTextTheme.titleSmall?.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const Spacer(),
  //               Text(
  //                 '${AppConstants.currencySymbol} ${cartController.totalCartAmount}',
  //                 style: context.appTextTheme.titleSmall?.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               KElevatedButton(
  //                 onPressed:
  //                     cartController.cartList.isEmpty ? null : onTapCheckout,
  //                 width: 120,
  //                 child: Text(
  //                   'Checkout',
  //                   style: context.buttonTextStyle,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // void onTapCheckout() {
  //   var token = LocalStorage.getData(key: LocalStorageKey.token);
  //   var isGuestCheckout = LocalStorage.getData(key: LocalStorageKey.isGuestCheckout);
  //
  //   if (token != null || isGuestCheckout == true) {
  //     Get.to(() => const CheckoutPage());
  //   } else {
  //     /// we need to update navigateToCheckoutPage value to navigate checkout page after logged in
  //     /// and verified a user
  //     Get.find<AuthController>().navigateToCheckoutPage(true);
  //
  //     /// navigate to login page
  //     Get.toNamed(RouteGenerator.login);
  //   }
  // }
}
