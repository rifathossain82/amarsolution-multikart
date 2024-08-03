import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder.dart';
import 'package:amarsolution_multikart/src/features/search/controller/product_search_controller.dart';
import 'package:amarsolution_multikart/src/features/search/view/widgets/popular_search_histories_widget.dart';
import 'package:amarsolution_multikart/src/features/search/view/widgets/search_histories_widget.dart';

class SearchPage extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final String? oldSearchText;

  const SearchPage({
    super.key,
    required this.onSearch,
    this.oldSearchText,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.find<ProductSearchController>();
  late final FocusNode focusNode;

  @override
  void initState() {
    searchController
      ..getPopularSearchHistories()
      ..getSearchHistories();

    searchController.setSearchText(widget.oldSearchText ?? '');

    focusNode = FocusNode()..requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: KTextFormFieldBuilder(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: searchController.searchText.value,
                  selection: TextSelection.collapsed(
                    offset: searchController.searchText.value.length,
                  ),
                ),
              ),
              focusNode: focusNode,
              onChanged: (text) {
                searchController.setSearchText(text);
                searchController.filterSearchResults(text);
              },
              hintText: 'Search...',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              inputType: TextInputType.text,
              inputAction: TextInputAction.search,
              onEditingComplete: () {
                widget.onSearch(searchController.searchText.value);
              },
              prefixIcon: const Icon(
                Icons.search,
                size: 22,
              ),
              suffix: searchController.searchText.value.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      icon: const Icon(
                        Icons.close,
                      ),
                      onPressed: () {
                        context.unFocusKeyboard;
                        searchController.clearSearch();
                      },
                    ),
            ),
          ),
        ),
        body: ListView(
          children: [
            SearchHistoriesWidget(
              searchController: searchController,
              onSearch: widget.onSearch,
            ),
            PopularSearchHistoriesWidget(
              searchController: searchController,
              onSearch: widget.onSearch,
            ),
          ],
        ),
      );
    });
  }
}
