import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/auth/view/pages/verify_otp_page.dart';
// import 'package:amarsolution_multikart/src/features/checkout/view/pages/checkout_page.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';
// import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';

class AuthController extends GetxController {
  var isLoginLoading = false.obs;
  var isVerifyOTPLoading = false.obs;
  var isLogoutLoading = false.obs;
  var navigateToCheckoutPage = false.obs;

  bool get isLoggedIn {
    final token = LocalStorage.getData(key: LocalStorageKey.token);
    return token != null;
  }

  Future login({
    required String phone,
  }) async {
    try {
      isLoginLoading(true);

      var requestBody = {
        'phone_no': phone,
        'country': 'Bangladesh',
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: Api.login,
          body: requestBody,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        /// to navigate verify otp page
        Get.to(() => VerifyOTPPage(phone: phone));

        /// show success message
        SnackBarService.showSnackBar(
          message: responseBody['message'],
          bgColor: successColor,
        );
      } else {
        String msg = 'Log in Failed!';

        if (responseBody['message'] != null) {
          msg = responseBody['message'];
        }

        throw msg;
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoginLoading(false);
    }
  }

  Future verifyOTP({
    required String phone,
    required String otp,
  }) async {
    try {
      isVerifyOTPLoading(true);

      /// To close previous snackBar
      /// TODO: Remove this code when OTP will send
      if (Get.isSnackbarOpen) {
        await Get.closeCurrentSnackbar();
      }

      var requestBody = {
        'phone_no': phone,
        'country': 'Bangladesh',
        'code': otp,
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: Api.verifyOTP,
          body: requestBody,
        ),
      );

      if (responseBody != null) {
        if (navigateToCheckoutPage.value) {
          _navigateToCheckoutPage();
        } else {
          _navigateToHomepage();
        }

        /// save token local storage
        LocalStorage.saveData(
          key: LocalStorageKey.token,
          data: responseBody['token'],
        );

        /// initialize profile controller to load user info in user controller
        /// we call getUserInfo in init method of userController
        // Get.find<ProfileController>();

        /// to show success message
        SnackBarService.showSnackBar(
          message: 'OTP Verification Completed!',
          bgColor: successColor,
        );
      } else {
        String msg = 'OTP Verification Failed!';

        if (responseBody['error'] != null) {
          msg = responseBody['error'];
        }

        throw msg;
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isVerifyOTPLoading(false);
    }
  }

  Future logout() async {
    try {
      isLogoutLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.logout,
        ),
      );

      if (responseBody != null) {
        /// clear all cache data from local storage
        LocalStorage.removeAllData();

        _navigateToHomepage();

        /// show success message
        SnackBarService.showSnackBar(
          message: 'Logout Successfully!',
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLogoutLoading(false);
    }
  }

  void _navigateToHomepage() {
    /// set dashboard index for homepage and go to dashboard
    Get.deleteAll();
    Get.find<DashboardController>().updateCurrentIndex(0);
    Get.offAllNamed(RouteGenerator.dashboard);
  }

  void _navigateToCheckoutPage() {
    /// delete all controller from state
    /// then set current index = 2 for cart page in dashboard bottom nav bar
    /// then pop all the pages
    /// then go checkout page
    Get.deleteAll();
    Get.find<DashboardController>().updateCurrentIndex(2);
    Get.offAllNamed(RouteGenerator.dashboard);
    // Get.to(() => const CheckoutPage());
  }
}
