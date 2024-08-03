import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_details_model.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/model/search_summary.dart';

class ProductController extends GetxController {
  var searchText = Rxn<String>();
  var selectedSortType = Rxn<String>();
  var priceRangeValues = Rxn<RangeValues>();
  var selectedBrands = <SummaryBrandModel>[].obs;
  var selectedSizes = <SummarySizeModel>[].obs;
  var selectedColors = <SummaryColorModel>[].obs;
  var selectedProductViewType = ProductsViewType.grid.obs;

  /// for product details
  var sliderIndex = 0.obs;

  var isProductListLoading = false.obs;
  var productList = <ProductModel>[].obs;
  final pageNumber = 1.obs;
  var loadedCompleted = true.obs;

  var isSearchSummaryLoading = false.obs;
  var searchSummary = Rxn<SearchSummaryModel>();

  var isProductDetailsLoading = false.obs;
  var productDetails = Rxn<ProductDetailsModel>();

  var isRelatedProductListLoading = false.obs;
  var relatedProductList = <ProductModel>[].obs;

  void updateSearchText(String? text) {
    searchText.value = text;
  }

  void updateSortType(String type) {
    selectedSortType.value = type;
  }

  void updatePriceRange(RangeValues rangeValues) {
    priceRangeValues.value = rangeValues;
  }

  void addNewBrand(SummaryBrandModel brand) {
    selectedBrands.add(brand);
  }

  void removeBrand(SummaryBrandModel brand) {
    selectedBrands.remove(brand);
  }

  void addNewSize(SummarySizeModel size) {
    selectedSizes.add(size);
  }

  void removeSize(SummarySizeModel size) {
    selectedSizes.remove(size);
  }

  void addNewColor(SummaryColorModel color) {
    selectedColors.add(color);
  }

  void removeColor(SummaryColorModel color) {
    selectedColors.remove(color);
  }

  void updateProductViewType(ProductsViewType type) {
    selectedProductViewType.value = type;
  }

  void updateSliderIndex(int index) {
    sliderIndex.value = index;
  }

  void resetFilter() {
    /// reset price range by search summary prices
    if (searchSummary.value != null) {
      updatePriceRange(
        RangeValues(
          searchSummary.value!.minPrice!.toDouble(),
          searchSummary.value!.maxPrice!.toDouble(),
        ),
      );
    }

    selectedBrands.value = [];
    selectedSizes.value = [];
    selectedColors.value = [];
  }

  Future<void> getProductList({
    required String api,
    List<String?>? categoryIds,
    List<String?>? brandIds,
    String? text,
    String? referenceId,
    String? sortType,
    List<String>? sizes,
    List<String>? colors,
    String? minPrice,
    String? maxPrice,
    bool reload = false,
  }) async {
    try {
      if (reload) {
        pageNumber.value = 1;
        productList.value = [];
        isProductListLoading(true);
        loadedCompleted(false);
      }

      final params = {
        "category_ids": categoryIds,
        "brand_ids": brandIds,
        "text": text,
        "reference_id": referenceId,
        "sort_type": sortType,
        "sizes": sizes,
        "colors": colors,
        "min_price": minPrice,
        "max_price": maxPrice,
        'per_page' : '20',
        'page' : '$pageNumber',
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: api,
          params: params,
        ),
      );

      if (responseBody != null) {
        if (responseBody['links']['next'] == null) {
          loadedCompleted(true);
        } else {
          loadedCompleted(false);
        }

        for (var i in responseBody['data']) {
          productList.add(ProductModel.fromJson(i));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isProductListLoading(false);
    }
  }

  Future<void> getSearchSummary() async {
    try {
      isSearchSummaryLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.searchSummary,
        ),
      );

      if (responseBody != null) {
        searchSummary.value = SearchSummaryModel.fromJson(responseBody);

        /// set the price range for filter
        if (searchSummary.value != null) {
          updatePriceRange(
            RangeValues(
              searchSummary.value!.minPrice!.toDouble(),
              searchSummary.value!.maxPrice!.toDouble(),
            ),
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
      isSearchSummaryLoading(false);
    }
  }

  Future<void> getProductDetails(String slug) async {
    try {
      isProductDetailsLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.productDetails(slug),
        ),
      );

      if (responseBody != null) {
        productDetails.value = ProductDetailsModel.fromJson(
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
      isProductDetailsLoading(false);
    }
  }

  Future<void> getRelatedProductList({
    required int productId,
    required String categoryId,
  }) async {
    try {
      isRelatedProductListLoading(true);
      relatedProductList.value = [];

      final params = {
        "category_ids": [categoryId],
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.productList,
          params: params,
        ),
      );

      if (responseBody != null) {
        for (var i in responseBody['data']) {
          var relatedProduct = ProductModel.fromJson(i);
          if (relatedProduct.id != productId) {
            relatedProductList.add(relatedProduct);
          }
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isRelatedProductListLoading(false);
    }
  }
}
