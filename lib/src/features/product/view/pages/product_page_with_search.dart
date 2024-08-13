import 'package:amarsolution_multikart/src/core/widgets/cart_icon_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/favorite_icon_widget.dart';
import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/filter_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_filter_drawer_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_widget.dart';
import 'package:amarsolution_multikart/src/features/search/view/pages/search_page.dart';

class ProductPageWithSearch extends StatefulWidget {
  final String api;
  final String? title;
  final String? categoryId;

  const ProductPageWithSearch({
    super.key,
    required this.api,
    this.title,
    this.categoryId,
  });

  @override
  State<ProductPageWithSearch> createState() => _ProductPageWithSearchState();
}

class _ProductPageWithSearchState extends State<ProductPageWithSearch> {
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        minPrice: '${productController.priceRangeValues.value?.start.floorToDouble() ?? ''}',
        maxPrice: '${productController.priceRangeValues.value?.end.floorToDouble() ?? ''}',
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
        key: _scaffoldKey,
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
          title: Text(widget.title ?? ''),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 0,
                bottom: 10,
              ),
              child: Row(
                children: [
                  _buildSearchBarWidget(),
                  const SizedBox(width: 12),
                  FilterIconButton(
                    onPressed: onPressedFilter,
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: changeProductViewType,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        productController.selectedProductViewType.value ==
                            ProductsViewType.list
                            ? Icons.list
                            : Icons.grid_view,
                        color: kWhite,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: const [
            FavoriteIconWidget(),
            SizedBox(width: 16),
            CartIconWidget(),
            SizedBox(width: 16),
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

  Widget _buildSearchBarWidget() {
    return Expanded(
      child: GestureDetector(
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
          height: 42,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: kGreyLight,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.search,
                  size: 16,
                ),
              ),
              Expanded(
                child: Text(
                  'Search',
                  style: context.appTextTheme.bodySmall,
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
      ),
    );
  }

  void onPressedFilter() {
    _scaffoldKey.currentState?.openEndDrawer();
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
