import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_drop_down_field_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/selectable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_custom_loader.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_outlined_button.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/model/search_summary.dart';

final sortTypes = {
  'default': 'Default',
  'new': 'New',
  'low_high': 'Price (Low to High)',
  'high_low': 'Price (High to Low)',
};

class ProductFilterDrawerWidget extends StatelessWidget {
  final ProductController productController;
  final VoidCallback onDone;
  final VoidCallback onReset;

  const ProductFilterDrawerWidget({
    super.key,
    required this.productController,
    required this.onDone,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Drawer(
        width: context.screenWidth,
        child: Scaffold(
          backgroundColor: kGreyLight,
          appBar: AppBar(
            title: Text(
              "Filters",
              style: context.titleLarge(),
            ),
          ),
          body: productController.isSearchSummaryLoading.value
              ? const KCustomLoader()
              : productController.searchSummary.value == null
                  ? const FailureWidgetBuilder()
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: kWhite,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _SortingWidget(
                                    productController: productController,
                                  ),
                                  _PriceWidget(
                                    productController: productController,
                                  ),
                                  _BrandsWidget(
                                    productController: productController,
                                  ),
                                  _ColorsWidget(
                                    productController: productController,
                                  ),
                                  _SizesWidget(
                                    productController: productController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          height: 60,
                          color: kWhite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: KOutlinedButton(
                                  onPressed: onReset,
                                  borderColor: kPrimaryColor,
                                  child: Text(
                                    'Reset'.toString(),
                                    style: context.outlinedButtonTextStyle(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: KButton(
                                  onPressed: onDone,
                                  child: Text(
                                    'apply filters'.toUpperCase(),
                                    style: context.buttonTextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      );
    });
  }
}

class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: context.titleMedium(),
      ),
    );
  }
}

class _SortingWidget extends StatelessWidget {
  final ProductController productController;

  const _SortingWidget({
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleText(text: "Sort By"),
          KDropDownFieldBuilder<String>(
            hintText: 'Select',
            isBorder: false,
            isExpanded: false,
            filled: true,
            fillColor: kGreyLight,
            items: sortTypes.keys.toList(),
            value: productController.selectedSortType.value,
            onChanged: (key) {
              productController.updateSortType(key);
            },
            itemBuilder: (key) => Text('${sortTypes[key]}'),
          ),
          const SizedBox(height: 15),
        ],
      );
    });
  }
}

class _PriceWidget extends StatelessWidget {
  final ProductController productController;

  const _PriceWidget({
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      RangeValues? priceRange = productController.priceRangeValues.value;
      SearchSummaryModel? searchSummary = productController.searchSummary.value;

      return priceRange != null &&
              searchSummary != null &&
              searchSummary.maxPrice! > 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TitleText(text: "Price"),
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
                const SizedBox(height: 15),
              ],
            )
          : const SizedBox();
    });
  }
}

class _ColorsWidget extends StatelessWidget {
  final ProductController productController;

  const _ColorsWidget({
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    final colorList = productController.searchSummary.value!.colors!;

    return colorList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TitleText(text: "Color"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: colorList
                    .map((color) => Obx(() {
                          return _SelectableItem(
                            value: color.name ?? '',
                            isSelected: _isColorSelected(color),
                            onTap: () {
                              if (_isColorSelected(color)) {
                                productController.removeColor(color);
                              } else {
                                productController.addNewColor(color);
                              }
                            },
                          );
                        }))
                    .toList(),
              ),
              const SizedBox(height: 15),
            ],
          )
        : const SizedBox();
  }

  bool _isColorSelected(SummaryColorModel color) {
    return productController.selectedColors.contains(color);
  }
}

class _SizesWidget extends StatelessWidget {
  final ProductController productController;

  const _SizesWidget({
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    final sizeList = productController.searchSummary.value!.sizes!;
    return sizeList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TitleText(text: "Size"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sizeList
                    .map((size) => Obx(() {
                          return _SelectableItem(
                            value: size.name ?? '',
                            isSelected: _isSizeSelected(size),
                            onTap: () {
                              if (_isSizeSelected(size)) {
                                productController.removeSize(size);
                              } else {
                                productController.addNewSize(size);
                              }
                            },
                          );
                        }))
                    .toList(),
              ),
              const SizedBox(height: 15),
            ],
          )
        : const SizedBox();
  }

  bool _isSizeSelected(SummarySizeModel size) {
    return productController.selectedSizes.contains(size);
  }
}

class _BrandsWidget extends StatelessWidget {
  final ProductController productController;

  const _BrandsWidget({
    required this.productController,
  });

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
                const _TitleText(
                  text: 'Brand',
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: brandList
                      .map((brand) => Obx(() {
                            return _SelectableItem(
                              value: brand.brandName ?? '',
                              isSelected: _isBrandSelected(brand),
                              onTap: () {
                                if (_isBrandSelected(brand)) {
                                  productController.removeBrand(brand);
                                } else {
                                  productController.addNewBrand(brand);
                                }
                              },
                            );
                          }))
                      .toList(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          )
        : const SizedBox();
  }

  bool _isBrandSelected(SummaryBrandModel brand) {
    return productController.selectedBrands.contains(brand);
  }
}

class _SelectableItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String value;

  const _SelectableItem({
    required this.onTap,
    required this.isSelected,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableContainer(
      height: 40,
      width: context.screenWidth * 0.45,
      isSelected: isSelected,
      unSelectedBgColor: kGreyLight,
      selectedBgColor: kPrimaryColor,
      borderRadius: 4,
      onTap: onTap,
      child: Text(
        value,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: context.bodyMedium(
          fontWeight: FontWeight.w700,
          color: isSelected ? kWhite : kBlackLight,
        ),
      ),
    );
  }
}
