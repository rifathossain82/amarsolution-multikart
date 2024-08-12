import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/checkout/controller/checkout_controller.dart';
import 'package:amarsolution_multikart/src/features/product/controller/full_screen_image_controller.dart';
import 'package:amarsolution_multikart/src/features/search/controller/product_search_controller.dart';
import 'package:amarsolution_multikart/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/category/controller/category_controller.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';
import 'package:amarsolution_multikart/src/features/home/controller/homepage_controller.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/controller/variant_selector_bottom_sheet_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/shop_info/controller/shop_info_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => HomepageController(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => ProductSearchController(), fenix: true);
    Get.lazyPut(() => VariantSelectorBottomSheetController(), fenix: true);
    Get.lazyPut(() => ShopInfoController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => CheckoutController(), fenix: true);
    Get.lazyPut(() => WishlistController(), fenix: true);
    Get.lazyPut(() => FullScreenImageController(), fenix: true);
  }
}
