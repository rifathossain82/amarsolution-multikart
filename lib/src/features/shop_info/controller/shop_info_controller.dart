import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/shop_info/model/payment_method_model.dart';
import 'package:amarsolution_multikart/src/features/shop_info/model/shop_info_model.dart';

class ShopInfoController extends GetxController {
  var isShopInfoLoading = false.obs;
  var shopInfo = Rxn<ShopInfoModel>();

  var isPaymentMethodLoading = false.obs;
  var paymentMethods = Rxn<PaymentMethodModel>();

  @override
  void onInit() {
    getShopInfo();
    getPaymentMethods();
    super.onInit();
  }

  Future<void> getShopInfo() async {
    try {
      isShopInfoLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.shopInfo,
        ),
      );

      if (responseBody != null) {
        shopInfo.value = ShopInfoModel.fromJson(responseBody['data']);

        /// Save guest checkout status on local storage.
        LocalStorage.saveData(
          key: LocalStorageKey.isGuestCheckout,
          data: shopInfo.value?.guestCheckout == 1,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isShopInfoLoading(false);
    }
  }

  Future<void> getPaymentMethods() async {
    try {
      isPaymentMethodLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.paymentMethods,
        ),
      );

      if (responseBody != null) {
        paymentMethods.value = PaymentMethodModel.fromJson(
          responseBody['data'],
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isPaymentMethodLoading(false);
    }
  }
}
