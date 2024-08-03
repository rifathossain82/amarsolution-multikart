import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/search/controller/product_search_controller.dart';
import 'package:amarsolution_multikart/src/features/search/model/search_history_model.dart';
import 'package:amarsolution_multikart/src/features/search/view/widgets/search_histories_loading_widget.dart';

class SearchHistoriesWidget extends StatelessWidget {
  final ProductSearchController searchController;
  final ValueChanged<String> onSearch;

  const SearchHistoriesWidget({
    Key? key,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return searchController.isSearchHistoriesLoading.value
          ? const SearchHistoriesLoadingWidget()
          : searchController.searchHistories.isEmpty
              ? const SizedBox()
              : _SearchHistoriesWidget(
                  searchController: searchController,
                  onSearch: onSearch,
                );
    });
  }
}

class _SearchHistoriesWidget extends StatelessWidget {
  final ProductSearchController searchController;
  final ValueChanged<String> onSearch;

  const _SearchHistoriesWidget({
    Key? key,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
            bottom: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently searched',
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.find<ProductSearchController>().deleteAllSearchHistory();
                },
                child: Text(
                  'Delete All',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: kDeepOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchController.searchHistories.length,
          itemBuilder: (context, index) => _SearchHistoryItemWidget(
            searchHistory: searchController.searchHistories[index],
            onSearch: onSearch,
          ),
        ),
      ],
    );
  }
}

class _SearchHistoryItemWidget extends StatelessWidget {
  final SearchHistoryModel searchHistory;
  final ValueChanged<String> onSearch;

  const _SearchHistoryItemWidget({
    Key? key,
    required this.searchHistory,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onSearch(searchHistory.searchName ?? '');
      },
      dense: true,
      horizontalTitleGap: 8,
      leading: const Icon(Icons.history),
      title: Text(
        searchHistory.searchName ?? '',
      ),
      trailing: GestureDetector(
        onTap: () {
          Get.find<ProductSearchController>().deleteSearchHistory(
            id: searchHistory.id!,
          );
        },
        child: const Icon(
          Icons.delete,
          size: 20,
        ),
      ),
    );
  }
}
