import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';

class CategoryController extends GetxController {
  final Rx<int> _selectedSubCategoryIndex = Rx<int>(-1);

  var isCategoryListLoading = false.obs;
  var categoryList = <CategoryModel>[].obs;
  final pageNumber = 1.obs;
  var loadedCompleted = true.obs;

  int get selectedSubCategoryIndex => _selectedSubCategoryIndex.value;

  @override
  void onInit() {
    getCategoryList(reload: true);
    super.onInit();
  }

  void updateSubCategoryIndex(int index) {
    _selectedSubCategoryIndex.value = index;
  }

  Future<void> getCategoryList({
    bool reload = false,
  }) async {
    try {
      if (reload) {
        pageNumber.value = 1;
        categoryList.value = [];
        isCategoryListLoading(true);
        loadedCompleted(false);
      }

      // var params = {
      //   'no_child' : '1',
      // };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.categoryList,
        ),
      );

      if (responseBody != null) {
        if (responseBody['links']['next'] == null) {
          loadedCompleted(true);
        } else {
          loadedCompleted(false);
        }

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
}
