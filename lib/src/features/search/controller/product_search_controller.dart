import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/network/network_utils.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/search/model/search_history_model.dart';

class ProductSearchController extends GetxController {
  final searchText = RxString('');

  void setSearchText(String text) {
    searchText.value = text;
  }

  void clearSearchText() {
    searchText.value = '';
  }

  var isPopularSearchHistoriesLoading = false.obs;
  var popularSearchHistories = <SearchHistoryModel>[].obs;

  var isSearchHistoriesLoading = false.obs;
  var searchHistories = <SearchHistoryModel>[].obs;

  /// For filtering
  var tempPopularSearchHistories = <SearchHistoryModel>[].obs;
  var tempSearchHistories = <SearchHistoryModel>[].obs;

  var isDeleteLoading = false.obs;
  var isDeleteAllLoading = false.obs;

  void clearSearch(){
    clearSearchText();
    popularSearchHistories.value = tempPopularSearchHistories;
    searchHistories.value = tempSearchHistories;
  }

  void filterSearchResults(String query) {
    /// If the search query is empty, show all items
    if (query.isEmpty) {
      popularSearchHistories.value = tempPopularSearchHistories;
      searchHistories.value = tempSearchHistories;
    } else {
      /// Filter popularSearchHistories based on the search query
      var filteredPopularSearchHistories = tempPopularSearchHistories
          .where((history) =>
          history.searchName!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      /// Filter searchHistories based on the search query
      var filteredSearchHistories = tempSearchHistories
          .where((history) =>
          history.searchName!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      /// Update the filtered lists
      popularSearchHistories.value = filteredPopularSearchHistories ;
      searchHistories.value = filteredSearchHistories;
    }
  }

  Future<void> getPopularSearchHistories() async {
    try {
      isPopularSearchHistoriesLoading(true);
      popularSearchHistories.value = [];
      tempPopularSearchHistories.value  = [];

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getPopularSearchHistories,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          popularSearchHistories.add(SearchHistoryModel.fromJson(item));
          tempPopularSearchHistories.add(SearchHistoryModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isPopularSearchHistoriesLoading(false);
    }
  }

  Future<void> getSearchHistories() async {
    try {
      if (!Get.find<AuthController>().isLoggedIn) {
        return;
      }

      isSearchHistoriesLoading(true);
      searchHistories.value = [];
      tempSearchHistories.value = [];

      var params = {
        'reference_id': LocalStorage.getData(key: LocalStorageKey.userId),
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getSearchHistories,
          params: params,
        ),
      );

      if (responseBody != null) {
        for (var item in responseBody['data']) {
          searchHistories.add(SearchHistoryModel.fromJson(item));
          tempSearchHistories.add(SearchHistoryModel.fromJson(item));
        }
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isSearchHistoriesLoading(false);
    }
  }

  Future<void> deleteSearchHistory({required int id}) async {
    try {
      isDeleteLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.deleteRequest(
          api: Api.deleteSearchHistory(
            id: id,
            referenceId: LocalStorage.getData(key: LocalStorageKey.userId),
          ),
        ),
      );

      if (responseBody != null && responseBody['status'] == true) {
        SnackBarService.showSnackBar(
          message: 'Search history deleted successfully!',
          bgColor: successColor,
        );


        /// refresh search list
        getSearchHistories();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isDeleteLoading(false);
    }
  }

  Future<void> deleteAllSearchHistory() async {
    try {
      isDeleteAllLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.deleteRequest(
          api: Api.deleteAllSearchHistory(
            referenceId: LocalStorage.getData(key: LocalStorageKey.userId),
          ),
        ),
      );

      if (responseBody != null && responseBody['status'] == true) {
        SnackBarService.showSnackBar(
          message: 'All Search history deleted successfully!',
          bgColor: successColor,
        );

        /// refresh search list
        getSearchHistories();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    } finally {
      isDeleteAllLoading(false);
    }
  }
}
