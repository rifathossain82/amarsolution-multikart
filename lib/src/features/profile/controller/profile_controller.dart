import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/model/user_model.dart';

class ProfileController extends GetxController {
  var isUserInfoLoading = false.obs;
  var userInfo = Rxn<UserModel>();

  var isUserUpdateLoading = false.obs;

  @override
  void onInit() {
    if(Get.find<AuthController>().isLoggedIn){
      getUserInfo();
    }
    super.onInit();
  }

  Future getUserInfo() async {
    try {
      isUserInfoLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.userInfo,
        ),
      );

      if (responseBody != null && responseBody['status'] == true) {
        userInfo.value = UserModel.fromJson(responseBody['data']);

        /// save userId in local storage
        LocalStorage.saveData(
          key: LocalStorageKey.userId,
          data: '${userInfo.value?.id}',
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isUserInfoLoading(false);
    }
  }

  Future updateUser({
    required UserModel user,
    String? filePath,
  }) async {
    try {
      isUserUpdateLoading(true);

      final Map<String, String> requestBody = {
        'name' : user.name ?? '',
        'gender' : user.gender ?? '',
        'birth_date' : '${user.birthDate ?? ''}',
        'email' : '${user.email ?? ''}',
        'alt_phone_no' : '${user.altPhoneNo ?? ''}',
        'address' : '${user.address ?? ''}',
        'city' : '${user.city ?? ''}',
        'country' : user.country ?? '',
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.multipartAddRequest(
          api: Api.updateUser,
          body: requestBody,
          filePaths: filePath != null ? [filePath] : [],
          fileKeyNames: filePath != null ? ['image'] : [],
        ),
      );

      if (responseBody != null && responseBody['status'] == true) {
        /// To show success message
        SnackBarService.showSnackBar(
          message: "Profile Updated Successfully!",
          bgColor: successColor,
        );

        /// To reload user
        getUserInfo();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isUserUpdateLoading(false);
    }
  }
}
