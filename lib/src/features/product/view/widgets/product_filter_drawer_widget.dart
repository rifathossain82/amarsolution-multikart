import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_checkbox_list_tile_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_custom_loader.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_outlined_button.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/model/search_summary.dart';

const _checkBoxItemHeight = 35.0;

class ProductFilterDrawerWidget extends StatelessWidget {
  final ProductController productController;
  final VoidCallback onDone;
  final VoidCallback onReset;

  const ProductFilterDrawerWidget({
    Key? key,
    required this.productController,
    required this.onDone,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Drawer(
        width: context.screenWidth - 100,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: productController.isSearchSummaryLoading.value
                ? const KCustomLoader()
                : productController.searchSummary.value == null
                    ? const FailureWidgetBuilder()
                    : Column(
                        children: [
                          Expanded(
                            flex: 9,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _PriceWidget(
                                    productController: productController,
                                  ),
                                  _ColorsWidget(
                                    productController: productController,
                                  ),
                                  _SizesWidget(
                                    productController: productController,
                                  ),
                                  _BrandsWidget(
                                    productController: productController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: KOutlinedButton(
                          //           onPressed: onReset,
                          //           borderColor: kPrimaryColor,
                          //           child: Text(
                          //             'Reset',
                          //             style: context.outlinedButtonTextStyle,
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(width: 15),
                          //       Expanded(
                          //         child: KButton(
                          //           onPressed: onDone,
                          //           child: Text(
                          //             'Done',
                          //             style: context.buttonTextStyle,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 210,
                          //   child: KDropDownFieldBuilder<String>(
                          //     hintText: 'Sorting',
                          //     isBorder: false,
                          //     isExpanded: false,
                          //     items: sortTypes.keys.toList(),
                          //     value: productController.selectedSortType.value,
                          //     onChanged: (key) {
                          //       productController.updateSortType(key);
                          //       getProducts(reload: true);
                          //     },
                          //     itemBuilder: (key) => Text('${sortTypes[key]}'),
                          //   ),
                          // ),
                        ],
                      ),
          ),
        ),
      );
    });
  }
}

class _PriceWidget extends StatelessWidget {
  final ProductController productController;

  const _PriceWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      RangeValues? priceRange = productController.priceRangeValues.value;
      SearchSummaryModel? searchSummary = productController.searchSummary.value;
      return priceRange != null &&
              searchSummary != null &&
              searchSummary.maxPrice! > 0
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By Price',
                    style: context.appTextTheme.titleMedium,
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: searchSummary.minPrice!.toDouble(),
                    max: searchSummary.maxPrice!.toDouble(),
                    labels: RangeLabels(
                      '${priceRange.start.round()}',
                      '${priceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      productController.updatePriceRange(values);
                    },
                    divisions: searchSummary.maxPrice! < 1
                        ? null
                        : searchSummary.maxPrice!.floor(),
                    activeColor: kPrimaryColor,
                    inactiveColor: kGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tk. ${priceRange.start.round()}',
                        style: context.appTextTheme.bodySmall,
                      ),
                      Text(
                        'Tk. ${priceRange.end.round()}',
                        style: context.appTextTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }
}

class _ColorsWidget extends StatelessWidget {
  final ProductController productController;

  const _ColorsWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorList = productController.searchSummary.value!.colors!;
    return colorList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'By Colors',
                  style: context.appTextTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: colorList.length < 3
                      ? _checkBoxItemHeight * colorList.length
                      : _checkBoxItemHeight * 3,
                  child: ListView.builder(
                    itemCount: colorList.length,
                    itemBuilder: (context, index) => Obx(() {
                      final color = colorList[index];
                      return KCheckboxListTileWidget(
                        title: color.name ?? '',
                        value: productController.selectedColors.contains(color),
                        onChanged: (value) {
                          if (value!) {
                            productController.addNewColor(color);
                          } else {
                            productController.removeColor(color);
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class _SizesWidget extends StatelessWidget {
  final ProductController productController;

  const _SizesWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeList = productController.searchSummary.value!.sizes!;
    return sizeList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'By Sizes',
                  style: context.appTextTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: sizeList.length < 3
                      ? _checkBoxItemHeight * sizeList.length
                      : _checkBoxItemHeight * 3,
                  child: ListView.builder(
                    itemCount: sizeList.length,
                    itemBuilder: (context, index) => Obx(() {
                      final size = sizeList[index];
                      return KCheckboxListTileWidget(
                        title: size.name ?? '',
                        value: productController.selectedSizes.contains(size),
                        onChanged: (value) {
                          if (value!) {
                            productController.addNewSize(size);
                          } else {
                            productController.removeSize(size);
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class _BrandsWidget extends StatelessWidget {
  final ProductController productController;

  const _BrandsWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brandList = productController.searchSummary.value!.brands!;
    return brandList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'By Brand',
                  style: context.appTextTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: brandList.length < 3
                      ? _checkBoxItemHeight * brandList.length
                      : _checkBoxItemHeight * 3,
                  child: ListView.builder(
                    itemCount: brandList.length,
                    itemBuilder: (context, index) => Obx(() {
                      final brand = brandList[index];
                      return KCheckboxListTileWidget(
                        title: brand.brandName ?? '',
                        value: productController.selectedBrands.contains(brand),
                        onChanged: (value) {
                          if (value!) {
                            productController.addNewBrand(brand);
                          } else {
                            productController.removeBrand(brand);
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
