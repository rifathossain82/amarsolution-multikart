import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';

class WishlistController extends GetxController{
  var isWishlistAddLoading = false.obs;
  var isWishlistDeleteLoading = false.obs;
  var isWishlistItemsLoading = false.obs;
  var wishlistItems = <ProductModel>[].obs;

  bool checkProductStatus(int productId){
    return wishlistItems.any((item) => item.id == productId);
  }

  Future<void> getWishlistItems() async {
    try {
      if(!Get.find<AuthController>().isLoggedIn){
        return;
      }
      isWishlistItemsLoading(true);
      wishlistItems.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getAllWishlist,
        ),
      );

      if (responseBody != null) {
        for(var item in responseBody['data']){
          wishlistItems.add(ProductModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isWishlistItemsLoading(false);
    }
  }

  Future<void> addWishlistItem({required int productId}) async {
    try {
      isWishlistAddLoading(true);

      var requestBody = {
        'product_id' : '$productId',
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: Api.addWishlist,
          body: requestBody,
        ),
      );

      if (responseBody != null) {
        /// show success message
        SnackBarService.showSnackBar(
          message: 'Product added to wishlist!',
          bgColor: successColor,
        );

        /// refresh wishlist
        getWishlistItems();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isWishlistAddLoading(false);
    }
  }

  Future<void> deleteWishlistItem({required int productId}) async {
    try {
      isWishlistDeleteLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.deleteRequest(
          api: Api.deleteWishlist(productId),
        ),
      );

      if (responseBody != null) {
        /// show success message
        SnackBarService.showSnackBar(
          message: 'Product deleted from wishlist!',
          bgColor: successColor,
        );

        /// refresh wishlist
        getWishlistItems();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isWishlistDeleteLoading(false);
    }
  }
}