import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';
import 'package:amarsolution_multikart/src/features/home/model/banner_model.dart';
import 'package:amarsolution_multikart/src/features/home/model/homepage_category_model.dart';
import 'package:amarsolution_multikart/src/features/home/model/slider_model.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';

class HomepageController extends GetxController {
  final sliderIndex = 0.obs;

  var isCategoryListLoading = false.obs;
  var categoryList = <CategoryModel>[].obs;

  var isSliderListLoading = false.obs;
  var sliderList = <SliderModel>[].obs;

  var isBannerListLoading = false.obs;
  var bannerList = <BannerModel>[].obs;

  var isNewArrivalProductListLoading = false.obs;
  var newArrivalProductList = <ProductModel>[].obs;

  var isFlashSalesProductListLoading = false.obs;
  var flashSalesProductList = <ProductModel>[].obs;
  var flashSalesExpireTime = Rxn<DateTime>();

  var isBestSalesProductListLoading = false.obs;
  var bestSalesProductList = <ProductModel>[].obs;

  var isHomepageCategoryListLoading = false.obs;
  var homepageCategoryList = <HomepageCategoryModel>[].obs;

  @override
  void onInit() {
    getCategoryList();
    getSliderList();
    getNewArrivalProductList();
    getFlashSalesProductList();
    getBestSalesProductList();
    getHomepageCategoryList();
    super.onInit();
  }

  void updateSliderIndex(int index) {
    sliderIndex.value = index;
  }

  Future<void> getCategoryList() async {
    try {
      isCategoryListLoading(true);
      categoryList.value = [];

      var params = {
        'no_child': '1',
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.categoryList,
          params: params,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          categoryList.add(CategoryModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isCategoryListLoading(false);
    }
  }

  Future<void> getSliderList() async {
    try {
      isSliderListLoading(true);
      sliderList.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.sliderList,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          sliderList.add(SliderModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isSliderListLoading(false);
    }
  }

  Future<void> getBannerList() async {
    try {
      isBannerListLoading(true);
      bannerList.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.bannerList,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          bannerList.add(BannerModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isBannerListLoading(false);
    }
  }

  Future<void> getNewArrivalProductList() async {
    try {
      isNewArrivalProductListLoading(true);
      newArrivalProductList.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.newArrivalProductList,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          newArrivalProductList.add(ProductModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isNewArrivalProductListLoading(false);
    }
  }

  Future<void> getFlashSalesProductList() async {
    try {
      isFlashSalesProductListLoading(true);
      flashSalesProductList.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.flashSalesProductList,
        ),
      );

      if (responseBody != null && responseBody['status'] == true) {
        for (var item in responseBody['data']) {
          flashSalesProductList.add(ProductModel.fromJson(item));
        }

        /// fetch flash sales expire dateTime
        flashSalesExpireTime.value = DateTime.parse(
          responseBody['flashSale']['expire_time'],
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isFlashSalesProductListLoading(false);
    }
  }

  Future<void> getBestSalesProductList() async {
    try {
      isBestSalesProductListLoading(true);
      bestSalesProductList.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.bestSalesProductList,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          bestSalesProductList.add(ProductModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isBestSalesProductListLoading(false);
    }
  }

  Future<void> getHomepageCategoryList() async {
    try {
      isHomepageCategoryListLoading(true);
      homepageCategoryList.value = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.homepageCategoryList,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          homepageCategoryList.add(HomepageCategoryModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isHomepageCategoryListLoading(false);
    }
  }
}
