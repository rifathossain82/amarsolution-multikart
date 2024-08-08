import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/helpers/validators.dart';
import 'package:amarsolution_multikart/src/core/services/loading_overlay.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/free_shipping_fee_alert_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_blank_field_builder_with_title.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button_progress_indicator.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:amarsolution_multikart/src/core/widgets/radio_list_tile_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/checkout/controller/checkout_controller.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/widgets/checkout_amounts_widget.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/widgets/checkout_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/widgets/checkout_payment_method_widget.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/widgets/checkout_products_widget.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/widgets/checkout_shipping_info_widget.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/shop_info/controller/shop_info_controller.dart';
import 'package:amarsolution_multikart/src/features/shop_info/model/payment_method_model.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final shopInfoController = Get.find<ShopInfoController>();
  final profileController = Get.find<ProfileController>();
  final cartController = Get.find<CartController>();
  final checkoutController = Get.find<CheckoutController>();

  /// For SSL-Commerce
  dynamic formData = {};
  int tranId = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: Obx(() {
        return shopInfoController.isShopInfoLoading.value ||
            shopInfoController.isPaymentMethodLoading.value ||
                profileController.isUserInfoLoading.value
            ? const CheckoutLoadingWidget()
            : _buildCheckoutBody();
      }),
    );
  }

  Widget _buildCheckoutBody() {
    /// update shipping info based on userInfo if checkout controller data is empty
    if (checkoutController.userName.value.isEmpty &&
        checkoutController.phoneNumber.isEmpty) {
      checkoutController.updateShippingInfo(
        userName: profileController.userInfo.value?.name ?? '',
        phoneNumber: profileController.userInfo.value?.phone ?? '',
        addressLine: profileController.userInfo.value?.address ?? '',
        city: profileController.userInfo.value?.city ?? '',
      );
    }

    final shopInfo = shopInfoController.shopInfo.value;

    /// Set cashOnDelivery as default payment method.
    PaymentMethodModel? paymentMethods = shopInfoController.paymentMethods.value;
    if(paymentMethods?.cashOnDelivery != null){
      checkoutController.updatePaymentMethodKey(
        paymentMethods!.cashOnDelivery!.key!,
      );
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (shopInfo?.freeDeliveryChargesLimit != null &&
                    shopInfo!.freeDeliveryChargesLimit! > 0)
                  FreeShippingFeeAlertWidget(
                    freeShippingFeeLimit:
                        shopInfo.freeDeliveryChargesLimit ?? 0,
                  ),
                CheckoutShippingInfoWidget(
                  checkoutController: checkoutController,
                  onTapShippingInfo: _buildShippingInfoBottomSheet,
                  onTapPhoneNumber: _buildGuestPhoneNumberBottomSheet,
                ),
                CheckoutProductsWidget(
                  tileIndex: checkoutController.productsTileIndex.value,
                  cartList: cartController.cartList,
                  totalAmount: cartController.totalCartAmount,
                  onExpansionChanged: (value) {
                    if (value) {
                      checkoutController.updateProductsTileIndex(-1);
                    } else {
                      checkoutController.updateProductsTileIndex(1);
                    }
                  },
                ),
                CheckoutAmountsWidget(
                  subtotal: cartController.totalCartAmount,
                  shippingFee: shippingFee,
                  couponDiscount: checkoutController.couponDiscountAmount.value,
                  onTapAddCoupon: () => _buildApplyCouponBottomSheet(),
                  totalWithDiscount: totalWithDiscount,
                  grandTotal: grandTotal,
                ),
                CheckoutPaymentMethodWidget(
                  shopInfoController: shopInfoController,
                  checkoutController: checkoutController,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kWhite,
            boxShadow: [
              KBoxShadow.itemShadow(),
            ],
          ),
          child: Row(
            children: [
              Text(
                'Pay Amount:',
                style: context.appTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${AppConstants.currencySymbol} $grandTotal',
                style: context.appTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              const Spacer(),
              KButton(
                onPressed: onPlaceOrder,
                width: 120,
                child: checkoutController.isCheckoutLoading.value
                    ? const KButtonProgressIndicator()
                    : Text(
                        'Place Order',
                        style: context.buttonTextStyle(),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  num get shippingFee {
    final shopInfo = shopInfoController.shopInfo.value;

    /// initially set fee by delivery option (inside or outside based)
    num shippingFee = checkoutController.isShippingInsideDhaka.value
        ? shopInfo?.insideDhakaDeliveryCharges ?? 0
        : shopInfo?.outsideDhakaDeliveryCharges ?? 0;

    /// if has delivery charge limit, and total amount is bigger than limit
    /// then set 0.0 as shipping fee
    if (shopInfo?.freeDeliveryChargesLimit != null &&
        shopInfo!.freeDeliveryChargesLimit! > 0) {
      if (cartController.totalCartAmount > shopInfo.freeDeliveryChargesLimit!) {
        shippingFee = 0.0;
      }
    }

    /// finally return
    return shippingFee;
  }

  num get totalWithDiscount =>
      cartController.totalCartAmount -
      (checkoutController.couponDiscountAmount.value ?? 0.0);

  num get grandTotal => totalWithDiscount + shippingFee;

  void onPlaceOrder() {
    if (checkoutController.phoneNumber.isEmpty) {
      SnackBarService.showSnackBar(
        message: 'Please enter your phone number!',
        bgColor: failedColor,
      );
    } else if (checkoutController.addressLine.isEmpty ||
        checkoutController.city.isEmpty) {
      SnackBarService.showSnackBar(
        message: 'Please enter your shipping information!',
        bgColor: failedColor,
      );
    } else if (checkoutController.selectedPaymentMethodKey.value == null) {
      SnackBarService.showSnackBar(
        message: 'Please select a payment method!',
        bgColor: failedColor,
      );
    } else {
      /// Check for payment method status and key
      if (shopInfoController.paymentMethods.value != null) {
        String selectedKey = checkoutController.selectedPaymentMethodKey.value;
        String cod = shopInfoController.paymentMethods.value?.cashOnDelivery?.key ?? '';
        String ssl = shopInfoController.paymentMethods.value?.ssl?.key ?? '';

        bool isGuestCheckout = LocalStorage.getData(key: LocalStorageKey.isGuestCheckout) as bool;
        if(isGuestCheckout && selectedKey != cod){
          SnackBarService.showSnackBar(
            message: 'Guest must select Cash On Delivery!',
            bgColor: failedColor,
          );
        } else{
          if (selectedKey == cod) {
            completeCheckout();
          } else {
            // sslCommercePayment();
          }
        }
      } else {
        SnackBarService.showSnackBar(
          message: 'No payment methods found!',
          bgColor: failedColor,
        );
      }
    }
  }

  // Future<void> sslCommercePayment() async {
  //   Sslcommerz sslCommerce = Sslcommerz(
  //     initializer: SSLCommerzInitialization(
  //       multi_card_name: formData['multicard'],
  //       currency: SSLCurrencyType.BDT,
  //       product_category: "Products",
  //       total_amount: grandTotal.toDouble(),
  //       tran_id: tranId.toString(),
  //
  //       ///SSL Test
  //       ipn_url: "www.ipnurl.com",
  //       sdkType: SSLCSdkType.TESTBOX,
  //       store_id: 'testi6119f4717446f',
  //       store_passwd: 'testi6119f4717446f@ssl',
  //
  //       // ///SSL Live
  //       // ipn_url: "https://familytrust.com.bd/ipn",
  //       // sdkType: SSLCSdkType.LIVE,
  //       // store_id: 'familytrustshoplive',
  //       // store_passwd: '611B8BFD7581488684',
  //     ),
  //   );
  //   sslCommerce
  //       .addEMITransactionInitializer(
  //         sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
  //           emi_options: 1,
  //           emi_max_list_options: 3,
  //           emi_selected_inst: 2,
  //         ),
  //       )
  //       .addShipmentInfoInitializer(
  //         sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
  //           shipmentMethod: "yes",
  //           numOfItems: cartController.totalCartItems,
  //           shipmentDetails: ShipmentDetails(
  //             shipAddress1: checkoutController.addressLine.value,
  //             shipCity: checkoutController.city.value,
  //             shipCountry: 'Bangladesh',
  //             shipName: 'Ship name 1',
  //             shipPostCode: '1100',
  //           ),
  //         ),
  //       )
  //       .addCustomerInfoInitializer(
  //         customerInfoInitializer: SSLCCustomerInfoInitializer(
  //           customerName: checkoutController.userName.value,
  //           customerEmail: '',
  //           customerAddress1: checkoutController.addressLine.value,
  //           customerState: '',
  //           customerCity: checkoutController.city.value,
  //           customerPostCode: '1100',
  //           customerCountry: 'Bangladesh',
  //           customerPhone: checkoutController.phoneNumber.value,
  //         ),
  //       )
  //       .addProductInitializer(
  //         sslcProductInitializer: SSLCProductInitializer(
  //           productName: "Gadgets",
  //           productCategory: "Widgets",
  //           general: General(
  //             general: "General Purpose",
  //             productProfile: "Product Profile",
  //           ),
  //         ),
  //       )
  //       .addAdditionalInitializer(
  //         sslcAdditionalInitializer: SSLCAdditionalInitializer(
  //           valueA: "app",
  //           valueB: "value b",
  //           valueC: "value c",
  //           valueD: "value d",
  //         ),
  //       );
  //   var result = await sslCommerce.payNow();
  //
  //   kPrint('SSL Result ====>$result');
  //   if (result is PlatformException) {
  //     kPrint("The response is: ${result.status}");
  //     SnackBarService.showSnackBar(
  //       message: 'Transaction failed!',
  //       bgColor: failedColor,
  //     );
  //
  //     // Navigator.pushNamed(context, OrderDetailsToPayment.routeName);
  //   } else {
  //     SSLCTransactionInfoModel model = result;
  //     kPrint("SSL json${model.toJson()}");
  //     if (model.aPIConnect == 'DONE' && model.status == 'VALID') {
  //       SnackBarService.showSnackBar(
  //         message: 'Payment success!',
  //         bgColor: successColor,
  //       );
  //
  //       /// call checkout method
  //       completeCheckout();
  //     } else {
  //       SnackBarService.showSnackBar(
  //         message: 'Payment Failed!',
  //         bgColor: failedColor,
  //       );
  //     }
  //   }
  // }

  // Future<void> paymentCheckout(double amount) async {
  //   // sandbox
  //   final flutterBkash = FlutterBkash();
  //
  //   //  production
  //   // final flutterBkash = FlutterBkash(
  //   //   credentials: BkashCredentials(
  //   //     username: "app_username",
  //   //     password: "app_password",
  //   //     appKey: "app_key",
  //   //     appSecret: "app_secret",
  //   //     isSandbox: false,
  //   //   ),
  //   // );
  //
  //   /// Goto BkashPayment page & pass the params
  //   try {
  //     /// call pay method to pay without agreement as parameter pass the context, amount, merchantInvoiceNumber
  //     final result = await flutterBkash.pay(
  //       context: context,
  //       // need the context as BuildContext
  //       amount: amount,
  //       // need it double type
  //       merchantInvoiceNumber: "tranId",
  //     );
  //
  //     /// if the payment is success then show the log
  //     print(result.toString());
  //
  //     /// if the payment is success then show the snack-bar
  //     _showSnackbar("(Success) tranId: ${result.trxId}");
  //   } on BkashFailure catch (e, st) {
  //     /// if something went wrong then show the log
  //     print(e.message);
  //     print(st);
  //
  //     /// if something went wrong then show the snack-bar
  //     _showSnackbar(e.message);
  //   } catch (e, st) {
  //     /// if something went wrong then show the log
  //     print(e);
  //     print(st);
  //
  //     /// if something went wrong then show the snack-bar
  //     _showSnackbar("Something went wrong");
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  //   return;
  // }

  void completeCheckout() {
    final requestBody = {
      "name": checkoutController.userName.value,
      "alt_name": checkoutController.userName.value,
      "phone": checkoutController.phoneNumber.value,
      "alt_phone": null,
      "address": checkoutController.addressLine.value,
      "alt_address": null,
      "order_items": cartController.cartList
          .map((cartItem) => {
                "barcode_id": cartItem.variant?.id,
                "quantity": cartItem.quantity,
                "price": cartController.getCartItemPrice(cartItem),
              })
          .toList(),
      "payment_type": checkoutController.selectedPaymentMethodKey.value,
      "delivery_type": shippingFee == 0.0
          ? 'free delivery'
          : checkoutController.isShippingInsideDhaka.value
              ? "inside dhaka"
              : "outside dhaka",
      "delivery_charge": shippingFee,
      "coupon": checkoutController.appliedCoupon.value != null
          ? checkoutController.appliedCoupon.value!.code
          : null,
      "coupon_discount": checkoutController.couponDiscountAmount.value ?? 0.0,
      "subtotal": cartController.totalCartAmount,
      "after_discount": totalWithDiscount,
      "grand_total": grandTotal
    };

    /// request for checkout
    checkoutController.checkout(
      requestBody: requestBody,
    );
  }

  /// This bottom sheet only appear for guest customer.
  Future _buildGuestPhoneNumberBottomSheet() {
    final phoneTextController = TextEditingController();
    phoneTextController.text = checkoutController.phoneNumber.value;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// bottom sheet close button and title
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(
                          width: context.screenWidth,
                          child: Text(
                            'Shipping Phone Number',
                            textAlign: TextAlign.center,
                            style: context.appTextTheme.titleMedium?.copyWith(
                              color: kGrey,
                            ),
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// content
                    KTextFormFieldBuilderWithTitle(
                      controller: phoneTextController,
                      validator: Validators.phoneNumberValidator,
                      title: 'Phone Number',
                      hintText: 'Enter your phone number',
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.phone,
                    ),

                    const SizedBox(height: 10),

                    /// update button
                    KButton(
                      onPressed: () {
                        checkoutController.updateShippingInfo(
                          phoneNumber: phoneTextController.text.trim(),
                        );

                        /// To close the bottom sheet
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Update',
                        style: context.buttonTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future _buildShippingInfoBottomSheet() {
    final nameTextController = TextEditingController();
    final addressLineTextController = TextEditingController();
    final cityTextController = TextEditingController();
    var isShippingInsideDhaka = true;

    nameTextController.text = checkoutController.userName.value;
    addressLineTextController.text = checkoutController.addressLine.value;
    cityTextController.text = checkoutController.city.value;
    isShippingInsideDhaka = checkoutController.isShippingInsideDhaka.value;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// bottom sheet close button and title
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(
                          width: context.screenWidth,
                          child: Text(
                            'Shipping Information',
                            textAlign: TextAlign.center,
                            style: context.appTextTheme.titleMedium?.copyWith(
                              color: kGrey,
                            ),
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// content
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        KTextFormFieldBuilderWithTitle(
                          controller: nameTextController,
                          title: 'Name',
                          hintText: 'Enter your name',
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.name,
                        ),
                        KTextFormFieldBuilderWithTitle(
                          controller: addressLineTextController,
                          title: 'Address Line',
                          hintText: 'Enter address line',
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.streetAddress,
                        ),
                        KTextFormFieldBuilderWithTitle(
                          controller: cityTextController,
                          title: 'City',
                          hintText: 'Enter you city',
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.streetAddress,
                        ),
                        KBlankFieldBuilderWithTitle(
                          title: 'Shipping in',
                          content: Row(
                            children: [
                              Expanded(
                                child: RadioListTileWidget<bool>(
                                  title: 'Inside Dhaka',
                                  value: true,
                                  groupValue: isShippingInsideDhaka,
                                  onChanged: (value) {
                                    setState(() {
                                      isShippingInsideDhaka = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTileWidget<bool>(
                                  title: 'Outside Dhaka',
                                  value: false,
                                  groupValue: isShippingInsideDhaka,
                                  onChanged: (value) {
                                    setState(() {
                                      isShippingInsideDhaka = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// update button
                    KButton(
                      onPressed: () {
                        checkoutController.updateShippingInfo(
                          userName: nameTextController.text.trim(),
                          addressLine: addressLineTextController.text.trim(),
                          city: cityTextController.text.trim(),
                          isShippingInsideDhaka: isShippingInsideDhaka,
                        );

                        /// To close the bottom sheet
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Update',
                        style: context.buttonTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future _buildApplyCouponBottomSheet() {
    final formKey = GlobalKey<FormState>();
    final couponCodeTextController = TextEditingController();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// bottom sheet close button and title
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          SizedBox(
                            width: context.screenWidth,
                            child: Text(
                              'Apply Coupon',
                              textAlign: TextAlign.center,
                              style: context.appTextTheme.titleMedium?.copyWith(
                                color: kGrey,
                              ),
                            ),
                          ),
                          Positioned(
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.close,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      /// content
                      KTextFormFieldBuilderWithTitle(
                        controller: couponCodeTextController,
                        title: 'Coupon Code',
                        hintText: 'Enter your coupon code',
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                      ),

                      const SizedBox(height: 10),

                      /// update button
                      KButton(
                        onPressed: () async {
                          context.unFocusKeyboard();

                          /// request for apply coupon discount
                          LoadingOverlay.runAsyncTask(context, () async {
                            await checkoutController.applyCoupon(
                              couponCode: couponCodeTextController.text,
                              orderAmount: cartController.totalCartAmount,
                            );
                          }).then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          'Apply',
                          style: context.buttonTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
