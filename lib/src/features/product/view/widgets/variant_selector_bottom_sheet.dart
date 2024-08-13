import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/increment_decrement_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
import 'package:amarsolution_multikart/src/core/widgets/selectable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';

// import 'package:amarsolution_multikart/src/core/widgets/increment_decrement_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';

// import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';

// import 'package:amarsolution_multikart/src/core/widgets/selectable_container.dart';
import 'package:amarsolution_multikart/src/features/product/controller/variant_selector_bottom_sheet_controller.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_details_model.dart';

class VariantSelectorBottomSheet {
  static Future open({
    required BuildContext context,
    required VariantSelectorBottomSheetController variantController,
    required ProductDetailsModel productDetails,
    required String buttonName,
    required void Function(int quantity, Barcode barcode) onPressed,
  }) {
    /// initialize unique color list & variant list
    final List<String> colorList = getUniqueColors(productDetails);
    List<Barcode> variantListByColor = [];

    /// to set initially selected color & size
    if (colorList.isNotEmpty) {
      variantController.updateColor(colorList.first);
      variantListByColor = getSizesByColor(
        productDetails: productDetails,
        selectedColor: variantController.selectedColor ?? '',
      );
    }

    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) {
        return Obx(
          () {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// bottom sheet content
                  /// product image and prices
                  _ImageAndPrices(
                    productDetails: productDetails,
                    variantController: variantController,
                  ),

                  /// divider
                  const KDivider(height: 20),

                  /// colors
                  const _TitleTextWidget(title: 'Color'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      colorList.length,
                      (index) => SelectableContainer(
                        onTap: () {
                          variantController.updateColor(colorList[index]);
                          variantController.updateVariant(null);
                          variantController.updateQuantity(0);
                          variantListByColor = getSizesByColor(
                            productDetails: productDetails,
                            selectedColor: variantController.selectedColor!,
                          );
                        },
                        isDefaultSizeEnabled: true,
                        isSelected: variantController.selectedColor == colorList[index],
                        child: Text(
                          colorList[index],
                          style: context.appTextTheme.bodyMedium?.copyWith(
                            color: variantController.selectedColor ==
                                    colorList[index]
                                ? kWhite
                                : kBlackLight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// sizes
                  const _TitleTextWidget(title: 'Size'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      variantListByColor.length,
                      (index) => SelectableContainer(
                        onTap: () {
                          variantController
                              .updateVariant(variantListByColor[index]);

                          if (variantController.selectedVariant!.stockQty! <
                              1) {
                            variantController.updateQuantity(0);
                          } else {
                            variantController.updateQuantity(1);
                          }
                        },
                        isDefaultSizeEnabled: true,
                        isSelected: variantController.selectedVariant ==
                            variantListByColor[index],
                        child: Text(
                          '${variantListByColor[index].size}',
                          style: context.appTextTheme.bodyMedium?.copyWith(
                            color: variantController.selectedVariant ==
                                    variantListByColor[index]
                                ? kWhite
                                : kBlackLight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// divider
                  const KDivider(height: 20),

                  if (variantController.selectedVariant != null) ...[
                    _TitleTextWidget(
                      title:
                          'Stock Qty: ${variantController.selectedVariant!.stockQty ?? 0}',
                    ),
                    const SizedBox(height: 8),
                  ],

                  /// quantity
                  const _TitleTextWidget(title: 'Quantity'),
                  SizedBox(
                    width: 120,
                    child: IncrementDecrementWidget(
                      value: '${variantController.quantity}',
                      onIncrement: () {
                        if (variantController.selectedVariant != null) {
                          if (variantController.quantity <
                              variantController.selectedVariant!.stockQty!) {
                            variantController
                                .updateQuantity(variantController.quantity + 1);
                          } else {
                            SnackBarService.showSnackBar(
                              message: 'No more products!',
                              bgColor: failedColor,
                            );
                          }
                        } else {
                          SnackBarService.showSnackBar(
                            message: 'Please select sizes!',
                            bgColor: failedColor,
                          );
                        }
                      },
                      onDecrement: () {
                        if (variantController.quantity > 1) {
                          variantController
                              .updateQuantity(variantController.quantity - 1);
                        }
                      },
                    ),
                  ),

                  /// shipping
                  const _ProductShippingWidget(
                    hideSelectButton: true,
                  ),

                  /// buttons
                  const SizedBox(height: 5),
                  KButton(
                    onPressed: () {
                      if (variantController.selectedVariant == null) {
                        SnackBarService.showSnackBar(
                          message: 'Please select sizes!',
                          bgColor: failedColor,
                        );
                      } else if (variantController.selectedVariant!.stockQty! <
                          1) {
                        SnackBarService.showSnackBar(
                          message: 'Invalid Quantity!',
                          bgColor: failedColor,
                        );
                      } else {
                        onPressed(
                          variantController.quantity,
                          variantController.selectedVariant!,
                        );

                        /// to clear all variant data
                        variantController.clearAll();

                        /// close the bottom sheet
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      buttonName,
                      style: context.buttonTextStyle(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static List<String> getUniqueColors(ProductDetailsModel productDetails) {
    return productDetails.barcodes
            ?.map((variant) => '${variant.color}')
            .toSet()
            .toList() ??
        [];
  }

  static List<Barcode> getSizesByColor({
    required ProductDetailsModel productDetails,
    required String selectedColor,
  }) {
    return productDetails.barcodes
            ?.where((variant) => variant.color == selectedColor)
            .toList() ??
        [];
  }
}

class _ImageAndPrices extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final VariantSelectorBottomSheetController variantController;

  const _ImageAndPrices({
    required this.productDetails,
    required this.variantController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImageBuilder(
          imgURl: variantImage,
          borderRadius: BorderRadius.circular(6),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              variantController.selectedVariant != null
                  ? _variantPrice(context)
                  : _initialPrice(context),
              Text(
                'Selected: CN + Without Receiver',
                style: context.appTextTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get variantImage =>
      productDetails.photos
          ?.firstWhereOrNull(
              (photo) => photo.colorName == variantController.selectedColor)
          ?.image ??
      productDetails.image ??
      '';

  Widget _initialPrice(BuildContext context) {
    return productDetails.minimumWholesaleQuantity! > 0 &&
            variantController.quantity >=
                productDetails.minimumWholesaleQuantity!
        ? Row(
            children: [
              Text(
                '${AppConstants.currencySymbol} ${productDetails.wholesalePrice}',
                style: context.appTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(Wholesale)',
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                ),
              )
            ],
          )
        : PriceWidget(
            newPrice: productDetails.newPrice,
            oldPrice: productDetails.oldPrice,
            discountValue: productDetails.discountPercentage,
            discountType: "Percentage",
            newPriceStyle: context.appTextTheme.titleMedium?.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          );
  }

  Widget _variantPrice(BuildContext context) {
    return productDetails.minimumWholesaleQuantity! > 0 &&
            variantController.quantity >=
                productDetails.minimumWholesaleQuantity!
        ? Row(
            children: [
              Text(
                '${AppConstants.currencySymbol} ${variantController.selectedVariant?.wholesalePrice ?? 0}',
                style: context.appTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(Wholesale)',
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                ),
              )
            ],
          )
        : PriceWidget(
            newPrice:
                variantController.selectedVariant?.discountSellingPrice ?? 0,
            oldPrice: variantController.selectedVariant?.sellingPrice ?? 0,
            discountValue:
                variantController.selectedVariant?.discountValue ?? 0,
            discountType: variantController.selectedVariant?.discountType ?? "",
            newPriceStyle: context.appTextTheme.titleMedium?.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          );
  }
}

class _ProductShippingWidget extends StatelessWidget {
  final bool hideSelectButton;

  const _ProductShippingWidget({
    this.hideSelectButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping: ',
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.local_shipping,
                size: 20,
                color: kBlackLight,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '100% secure payment. 3 Days Return- If goods have problems',
                  style: context.appTextTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.flash_on,
                size: 20,
                color: kBlackLight,
              ),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ships in',
                      style: context.appTextTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ' 3-7 days',
                      style: context.appTextTheme.bodySmall?.copyWith(
                        color: kDeepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TitleTextWidget extends StatelessWidget {
  final String title;

  const _TitleTextWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Text(
        title,
        style: context.titleSmall(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
