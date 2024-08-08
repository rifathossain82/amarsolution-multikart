import 'dart:convert';

import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/checkout/model/checkout_response_model.dart';
import 'package:amarsolution_multikart/src/features/checkout/model/coupon_model.dart';
import 'package:amarsolution_multikart/src/features/checkout/view/pages/checkout_success_page.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';

class CheckoutController extends GetxController {
  var userName = ''.obs;
  var phoneNumber = ''.obs;
  var addressLine = ''.obs;
  var city = ''.obs;
  var isShippingInsideDhaka = true.obs;
  var note = ''.obs;
  var productsTileIndex = 1.obs;
  var selectedPaymentMethodKey = Rxn();

  var couponDiscountAmount = Rxn();
  var appliedCoupon = Rxn<CouponModel>();
  var isCouponDiscountLoading = false.obs;

  var isCheckoutLoading = false.obs;

  void updateProductsTileIndex(int index) {
    productsTileIndex.value = index;
  }

  void updatePaymentMethodKey(String key) {
    selectedPaymentMethodKey.value = key;
  }

  void updateShippingInfo({
    String? userName,
    String? phoneNumber,
    String? addressLine,
    String? city,
    bool? isShippingInsideDhaka,
  }) {
    if (userName != null) this.userName.value = userName;
    if (phoneNumber != null) this.phoneNumber.value = phoneNumber;
    if (addressLine != null) this.addressLine.value = addressLine;
    if (city != null) this.city.value = city;
    if (isShippingInsideDhaka != null) {
      this.isShippingInsideDhaka.value = isShippingInsideDhaka;
    }
  }

  void updateNote(String value) {
    note.value = value;
  }

  Future<void> applyCoupon({
    required String couponCode,
    required num orderAmount,
  }) async {
    try {
      isCouponDiscountLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.couponDetails,
        ),
      );

      if (responseBody != null) {
        List<CouponModel> couponList = [];
        for (var item in responseBody['data']) {
          couponList.add(CouponModel.fromJson(item));
        }

        /// find out the coupon
        CouponModel? coupon = couponList.firstWhereOrNull(
          (element) => element.code == couponCode,
        );

        /// set coupon amount based on coupon
        if (coupon != null) {
          _CouponDiscount couponDiscount = _CouponDiscount(
            coupon: coupon,
            orderAmount: orderAmount,
          );

          couponDiscountAmount.value = couponDiscount.calculateTotalDiscount();
          if (couponDiscountAmount.value != null) {
            appliedCoupon.value = coupon;
            SnackBarService.showSnackBar(
              message: 'Coupon Discount Added!',
              bgColor: successColor,
            );
          } else {
            SnackBarService.showSnackBar(
              message: 'Invalid Coupon Code!',
              bgColor: failedColor,
            );
          }
        } else {
          SnackBarService.showSnackBar(
            message: 'Invalid Coupon Code!',
            bgColor: failedColor,
          );
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isCouponDiscountLoading(false);
    }
  }

  Future<void> checkout({required Map<String, dynamic> requestBody}) async {
    try {
      isCheckoutLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: LocalStorage.getData(key: LocalStorageKey.isGuestCheckout) == true
                  ? Api.guestCheckout
                  : Api.checkout,
          body: jsonEncode(requestBody),
          addContentType: true,
        ),
      );

      if (responseBody != null) {
        /// To clear all cart items
        Get.find<CartController>().removedAllItems();

        /// Fetch checkout response and navigate to checkout success page.
        Get.offAll(
          () => CheckoutSuccessPage(
            checkoutResponse: CheckoutResponseModel.fromJson(responseBody),
          ),
        );

        /// To show success message
        SnackBarService.showSnackBar(
          message: 'Order Placed Successfully!',
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isCheckoutLoading(false);
    }
  }
}

class _CouponDiscount {
  final CouponModel coupon;
  final num orderAmount;

  /// Create a [_CouponDiscount] instance with a [coupon] and [orderAmount].
  const _CouponDiscount({
    required this.coupon,
    required this.orderAmount,
  });

  /// Calculate the total discount based on the coupon and order amount.
  ///
  /// This method checks if the coupon is valid within its date range, then applies
  /// the discount based on the coupon type and discount amount. For 'cart' type
  /// coupons, it handles both 'flat' and percentage discounts. If the calculated
  /// discount exceeds the [coupon.maxDiscount], it returns [coupon.maxDiscount].
  ///
  /// Returns the total discount amount or `null` if the coupon is not applicable.
  num? calculateTotalDiscount() {
    DateTime currentDate = DateTime.now();
    DateTime? startDate = coupon.startDate;
    DateTime? endDate = coupon.endDate;

    if (startDate == null || endDate == null) {
      // Coupon date range is not specified, not applicable.
      return null;
    } else if (currentDate.isBefore(startDate) ||
        currentDate.isAfter(endDate)) {
      // Coupon is not valid within the specified date range, not applicable.
      return null;
    } else {
      if (coupon.couponType == 'cart') {
        if (coupon.discountType == 'flat') {
          // Apply a flat discount
          return coupon.discountAmount;
        } else {
          // Apply a percentage discount
          num discountPercentage = coupon.discountAmount ?? 0;
          num discountAmount = (orderAmount * discountPercentage) / 100;

          if (coupon.maxDiscount != null &&
              (discountAmount > (coupon.maxDiscount ?? 0.0))) {
            return coupon.maxDiscount;
          } else {
            return discountAmount;
          }
        }
      } else {
        // Handle other coupon types (product-specific, etc.) if applicable
      }
    }
    return null;
  }
}
