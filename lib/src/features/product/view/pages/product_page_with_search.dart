import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_drop_down_field_builder.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_filter_drawer_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_widget.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/search/view/pages/search_page.dart';

class ProductPageWithSearch extends StatefulWidget {
  final String api;
  final String? title;
  final String? categoryId;

  const ProductPageWithSearch({
    Key? key,
    required this.api,
    this.title,
    this.categoryId,
  }) : super(key: key);

  @override
  State<ProductPageWithSearch> createState() => _ProductPageWithSearchState();
}

class _ProductPageWithSearchState extends State<ProductPageWithSearch> {
  final productController = Get.find<ProductController>();
  final ScrollController _scrollController = ScrollController();

  final sortTypes = {
    'default': 'Default',
    'new': 'New',
    'low_high': 'Price (Low to High)',
    'high_low': 'Price (High to Low)',
  };

  @override
  void initState() {
    productController.getSearchSummary();
    getProducts(reload: true);
    scrollIndicator();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getProducts({bool reload = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productController.getProductList(
        api: widget.api,
        reload: reload,
        text: productController.searchText.value,
        referenceId: LocalStorage.getData(key: LocalStorageKey.userId),
        categoryIds: [widget.categoryId ?? ''],
        sortType: productController.selectedSortType.value,
        brandIds: productController.selectedBrands
            .map((brand) => '${brand.id}')
            .toList(),
        colors: productController.selectedColors
            .map((color) => '${color.name}')
            .toList(),
        sizes: productController.selectedSizes
            .map((size) => '${size.name}')
            .toList(),
        minPrice:
            '${productController.priceRangeValues.value?.start.floorToDouble() ?? ''}',
        maxPrice:
            '${productController.priceRangeValues.value?.end.floorToDouble() ?? ''}',
      );
    });
  }

  void scrollIndicator({bool reload = false}) {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          kPrint('reach to bottom');
          if (!productController.loadedCompleted.value) {
            ++productController.pageNumber.value;
            getProducts();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        endDrawer: ProductFilterDrawerWidget(
          productController: productController,
          onDone: () {
            Navigator.pop(context);
            getProducts(reload: true);
          },
          onReset: () {
            Navigator.pop(context);
            productController.resetFilter();
            getProducts(reload: true);
          },
        ),
        endDrawerEnableOpenDragGesture: false,
        appBar: AppBar(
          titleSpacing: 0,
          title: _buildAppbarTitleWidget(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 0,
                bottom: 5,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 210,
                    child: KDropDownFieldBuilder<String>(
                      hintText: 'Sorting',
                      isBorder: false,
                      isExpanded: false,
                      items: sortTypes.keys.toList(),
                      value: productController.selectedSortType.value,
                      onChanged: (key) {
                        productController.updateSortType(key);
                        getProducts(reload: true);
                      },
                      itemBuilder: (key) => Text('${sortTypes[key]}'),
                    ),
                  ),
                  const Spacer(),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => onPressedFilter(context),
                      icon: const Icon(
                        Icons.filter_list,
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: changeProductViewType,
                    icon: Icon(
                      productController.selectedProductViewType.value ==
                              ProductsViewType.list
                          ? Icons.list
                          : Icons.grid_view,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.find<DashboardController>().updateCurrentIndex(2);
                Get.offAllNamed(RouteGenerator.dashboard);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
        body: productController.isProductListLoading.value
            ? ProductsLoadingWidget(
                viewType: productController.selectedProductViewType.value,
              )
            : productController.productList.isEmpty
                ? const FailureWidgetBuilder()
                : ProductsWidget(
                    viewType: productController.selectedProductViewType.value,
                    controller: _scrollController,
                    productList: productController.productList,
                    loadedComplete: productController.loadedCompleted.value,
                  ),
      );
    });
  }

  Widget _buildAppbarTitleWidget() {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SearchPage(
            oldSearchText: productController.searchText.value,
            onSearch: (value) {
              productController.updateSearchText(value);
              getProducts(reload: true);
              Get.back(); // to close the search page
            },
          ),
        );
      },
      child: Container(
        height: 38,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: kPrimaryColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.search,
                size: 20,
              ),
            ),
            Expanded(
              child: Text(
                productController.searchText.value ??
                    widget.title ??
                    'Search...',
                style: context.appTextTheme.bodyMedium,
              ),
            ),
            if (productController.searchText.value != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    productController.updateSearchText(null);
                    getProducts(reload: true);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onPressedFilter(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void changeProductViewType() {
    var currentViewType = productController.selectedProductViewType.value;
    if (currentViewType == ProductsViewType.grid) {
      productController.updateProductViewType(ProductsViewType.list);
    } else {
      productController.updateProductViewType(ProductsViewType.grid);
    }
  }
}
