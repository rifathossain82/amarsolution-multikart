import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/features/search/controller/product_search_controller.dart';
import 'package:amarsolution_multikart/src/features/search/model/search_history_model.dart';
import 'package:amarsolution_multikart/src/features/search/view/widgets/search_histories_loading_widget.dart';

class PopularSearchHistoriesWidget extends StatelessWidget {
  final ProductSearchController searchController;
  final ValueChanged<String> onSearch;

  const PopularSearchHistoriesWidget({
    Key? key,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return searchController.isPopularSearchHistoriesLoading.value
          ? const SearchHistoriesLoadingWidget()
          : searchController.popularSearchHistories.isEmpty
              ? const SizedBox()
              : _PopularSearchHistoriesWidget(
                  searchController: searchController,
                  onSearch: onSearch,
                );
    });
  }
}

class _PopularSearchHistoriesWidget extends StatelessWidget {
  final ProductSearchController searchController;
  final ValueChanged<String> onSearch;

  const _PopularSearchHistoriesWidget({
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
            top: 20,
            bottom: 4,
          ),
          child: Text(
            'Popular keywords',
            style: context.appTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchController.popularSearchHistories.length,
          itemBuilder: (context, index) => _PopularSearchHistoryItemWidget(
            searchHistory: searchController.popularSearchHistories[index],
            onSearch: onSearch,
          ),
        ),
      ],
    );
  }
}

class _PopularSearchHistoryItemWidget extends StatelessWidget {
  final SearchHistoryModel searchHistory;
  final ValueChanged<String> onSearch;

  const _PopularSearchHistoryItemWidget({
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
      leading: const Icon(
        Icons.trending_up,
        size: 20,
      ),
      title: Text(
        searchHistory.searchName ?? '',
      ),
    );
  }
}
