import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/loading_overlay.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
// import 'package:amarsolution_multikart/src/core/widgets/cart_icon_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/failure_widget_builder.dart';
// import 'package:amarsolution_multikart/src/core/widgets/k_html_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
// import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
// import 'package:amarsolution_multikart/src/core/widgets/price_widget.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
// import 'package:amarsolution_multikart/src/features/cart/controller/cart_controller.dart';
// import 'package:amarsolution_multikart/src/features/cart/model/cart_model.dart';
// import 'package:amarsolution_multikart/src/features/checkout/view/pages/checkout_page.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/controller/variant_selector_bottom_sheet_controller.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_details_model.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/full_screen_image_page.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/add_to_cart_button.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/buy_now_button.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/product_details_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/products_widget.dart';
import 'package:amarsolution_multikart/src/features/product/view/widgets/variant_selector_bottom_sheet.dart';
// import 'package:amarsolution_multikart/src/features/wishlist/controller/wishlist_controller.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  final productController = Get.find<ProductController>();
  // final cartController = Get.find<CartController>();
  // final wishlistController = Get.find<WishlistController>();
  final variantController = Get.find<VariantSelectorBottomSheetController>();

  @override
  void initState() {
    productController
      ..getProductDetails(widget.product.slug ?? '')
      ..getRelatedProductList(
        productId: widget.product.id!,
        categoryId: '${widget.product.category?.id}',
      );

    // wishlistController.getWishlistItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(() {
          return Text(
            productController.isProductDetailsLoading.value
                ? 'Product Name...'
                : productController.productDetails.value == null
                    ? 'Product Details'
                    : productController.productDetails.value?.productName ?? '',
          );
        }),
      ),
      // body: Obx(() {
      //   return productController.isProductDetailsLoading.value
      //       ? const ProductDetailsLoadingWidget()
      //       : productController.productDetails.value == null
      //           ? const FailureWidgetBuilder()
      //           : Column(
      //               children: [
      //                 Expanded(
      //                   flex: 10,
      //                   child: _productDetailsBody(),
      //                 ),
      //                 _productDetailsBottomWidget(),
      //               ],
      //             );
      // }),
    );
  }

  // Widget _productDetailsBody() {
  //   return ListView(
  //     shrinkWrap: true,
  //     physics: const ScrollPhysics(),
  //     children: [
  //       _ProductImageSlider(
  //         onPageChanged: (index, reason) {
  //           productController.updateSliderIndex(index);
  //         },
  //         sliderIndex: productController.sliderIndex.value,
  //         photos: productController.productDetails.value?.photos ?? [],
  //       ),
  //       _ProductInfoWidget(
  //         productDetails: productController.productDetails.value!,
  //         wishlistController: wishlistController,
  //       ),
  //       // _ProductShippingWidget(
  //       //   productDetails: productController.productDetails.value!,
  //       // ),
  //       if (productController.productDetails.value!.barcodes!.isNotEmpty)
  //         const _ProductVariationWidget(),
  //       _ProductDetailsWidget(
  //         productDetails: productController.productDetails.value!,
  //       ),
  //       _RelatedProductsWidget(
  //         productController: productController,
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _productDetailsBottomWidget() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: kWhite,
  //       boxShadow: [
  //         KBoxShadow.itemShadow(),
  //       ],
  //     ),
  //     height: 65,
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 10,
  //     ),
  //     alignment: Alignment.center,
  //     child: Row(
  //       children: [
  //         CartIconWidget(
  //           quantity: cartController.totalCartItems,
  //           onTap: () {
  //             Get.find<DashboardController>().updateCurrentIndex(2);
  //             Get.offAllNamed(RouteGenerator.dashboard);
  //           },
  //         ),
  //         const SizedBox(width: 15),
  //         Expanded(
  //           child: BuyNowButton(
  //             onTap: onTapBuyNow,
  //           ),
  //         ),
  //         Expanded(
  //           child: AddToCartButton(
  //             onTap: onTapAddToCart,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void onTapBuyNow() {
  //   var token = LocalStorage.getData(key: LocalStorageKey.token);
  //   bool isGuestCheckout = LocalStorage.getData(key: LocalStorageKey.isGuestCheckout) as bool;
  //
  //   if (token != null || isGuestCheckout) {
  //     if (productController.productDetails.value!.barcodes!.length > 1) {
  //       VariantSelectorBottomSheet.open(
  //         context: context,
  //         variantController: variantController,
  //         productDetails: productController.productDetails.value!,
  //         buttonName: 'Buy Now',
  //         onPressed: (quantity, productVariant) {
  //           buyNowMethod(quantity: quantity, productVariant: productVariant);
  //         },
  //       );
  //     } else {
  //       if (productController.productDetails.value!.stockQty! > 1) {
  //         buyNowMethod(
  //           quantity: 1,
  //           productVariant: productController.productDetails.value?.barcodes?.first,
  //         );
  //       } else {
  //         SnackBarService.showSnackBar(
  //           message: 'No more products!',
  //           bgColor: failedColor,
  //         );
  //       }
  //     }
  //   } else {
  //     Get.toNamed(RouteGenerator.login);
  //   }
  // }
  //
  // void onTapAddToCart() {
  //   if (productController.productDetails.value!.barcodes!.length > 1) {
  //     VariantSelectorBottomSheet.open(
  //       context: context,
  //       variantController: variantController,
  //       productDetails: productController.productDetails.value!,
  //       buttonName: 'Add to Cart',
  //       onPressed: (quantity, productVariant) {
  //         addToCartMethod(quantity: quantity, productVariant: productVariant);
  //       },
  //     );
  //   } else {
  //     if (productController.productDetails.value!.stockQty! > 1) {
  //       addToCartMethod(
  //         quantity: 1,
  //         productVariant: productController.productDetails.value?.barcodes?.first,
  //       );
  //     } else {
  //       SnackBarService.showSnackBar(
  //         message: 'No more products!',
  //         bgColor: failedColor,
  //       );
  //     }
  //   }
  // }
  //
  // void buyNowMethod({
  //   required int quantity,
  //   required Barcode? productVariant,
  // }) {
  //   /// at first add this item in cart
  //   cartController.addToCart(
  //     createCartModel(
  //       productDetails: productController.productDetails.value!,
  //       quantity: quantity,
  //       productVariant: productVariant,
  //     ),
  //   );
  //
  //   /// then set current index = 2 for dashboard bottom nav bar
  //   /// then pop all the pages
  //   /// then go checkout page
  //   Get.find<DashboardController>().updateCurrentIndex(2);
  //   Get.offAllNamed(RouteGenerator.dashboard);
  //   Get.to(() => const CheckoutPage());
  // }
  //
  // void addToCartMethod({
  //   required int quantity,
  //   required Barcode? productVariant,
  // }) {
  //   cartController.addToCart(
  //     createCartModel(
  //       productDetails: productController.productDetails.value!,
  //       quantity: quantity,
  //       productVariant: productVariant,
  //     ),
  //   );
  //
  //   SnackBarService.showSnackBar(
  //     message: 'Add To Cart Success!',
  //     bgColor: successColor,
  //   );
  // }
  //
  // CartModel createCartModel({
  //   required ProductDetailsModel productDetails,
  //   required int quantity,
  //   required Barcode? productVariant,
  // }) {
  //   CartModel? existingCartItem = cartController.getProduct(
  //     productId: productDetails.id!,
  //     variantId: productVariant?.id,
  //   );
  //
  //   if (existingCartItem != null) {
  //     quantity = existingCartItem.quantity! + quantity;
  //   }
  //
  //   return CartModel(
  //     productId: productDetails.id,
  //     productName: productDetails.productName,
  //     productImage: productDetails.image,
  //     quantity: quantity,
  //     stock: productVariant == null
  //         ? productDetails.stockQty
  //         : productVariant.stockQty,
  //     sellingPrice: productVariant?.sellingPrice ?? 0,
  //     discountSellingPrice: productVariant?.discountSellingPrice ?? 0,
  //     discountValue: productVariant?.discountValue ?? 0,
  //     discountType: productVariant?.discountType ?? "",
  //     wholesalePrice: productVariant?.wholesalePrice ?? 0,
  //     wholesaleQuantity: productDetails.minimumWholesaleQuantity,
  //     variant: productVariant == null
  //         ? null
  //         : CartVariant(
  //             id: productVariant.id,
  //             color: productVariant.color,
  //             size: productVariant.size,
  //           ),
  //   );
  // }
  //
  // /// It will return the product image to create cart model based on variant.
  // String? getProductImage({
  //   required ProductDetailsModel productDetails,
  //   Barcode? productVariant,
  // }) {
  //   return productVariant != null
  //       ? productDetails.photos
  //           ?.firstWhereOrNull(
  //               (photo) => photo.colorName == productVariant.color)
  //           ?.image
  //       : productDetails.image;
  // }
}

// class _ProductImageSlider extends StatelessWidget {
//   final Function(int, CarouselPageChangedReason)? onPageChanged;
//   final int sliderIndex;
//   final List<Photo> photos;
//
//   const _ProductImageSlider({
//     super.key,
//     required this.onPageChanged,
//     required this.sliderIndex,
//     required this.photos,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return photos.isEmpty
//         ? const SizedBox()
//         : Stack(
//             fit: StackFit.loose,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.to(
//                     () => FullScreenImagePage(
//                       photos: photos,
//                     ),
//                   );
//                 },
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     aspectRatio: 1.3,
//                     viewportFraction: 1,
//                     initialPage: 0,
//                     enableInfiniteScroll: false,
//                     reverse: false,
//                     autoPlay: false,
//                     autoPlayInterval: const Duration(seconds: 5),
//                     autoPlayAnimationDuration:
//                         const Duration(milliseconds: 1000),
//                     autoPlayCurve: Curves.easeInCubic,
//                     enlargeCenterPage: true,
//                     scrollDirection: Axis.horizontal,
//                     onPageChanged: onPageChanged,
//                   ),
//                   items: photos
//                       .map(
//                         (e) => CachedNetworkImageBuilder(
//                           imgURl: e.image ?? '',
//                           borderRadius: BorderRadius.zero,
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 left: 10,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 2,
//                     horizontal: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: kGreyLight,
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: [
//                       KBoxShadow.itemShadow(),
//                     ],
//                   ),
//                   child: Text(
//                     '${sliderIndex + 1}/${photos.length}',
//                     style: context.appTextTheme.bodyMedium?.copyWith(
//                       color: kBlackLight,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//   }
// }
//
// class _ProductInfoWidget extends StatelessWidget {
//   final ProductDetailsModel productDetails;
//   final WishlistController wishlistController;
//
//   const _ProductInfoWidget({
//     super.key,
//     required this.productDetails,
//     required this.wishlistController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).cardColor,
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     PriceWidget(
//                       newPrice: productDetails.newPrice,
//                       oldPrice: productDetails.oldPrice,
//                       discountValue: productDetails.discountPercentage,
//                       discountType: "Percentage",
//                       newPriceStyle: context.appTextTheme.titleMedium?.copyWith(
//                         color: kPrimaryColor,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//
//                     /// wholesale price and qty
//                     if (productDetails.minimumWholesaleQuantity != null &&
//                         productDetails.minimumWholesaleQuantity! > 0) ...[
//                       const SizedBox(height: 2),
//                       Row(
//                         children: [
//                           Text(
//                             'Wholesale Price: ${AppConstants.currencySymbol} ${productDetails.wholesalePrice}',
//                             style: context.appTextTheme.bodySmall,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             '(MOQ: ${productDetails.minimumWholesaleQuantity})',
//                             style: context.appTextTheme.bodySmall?.copyWith(
//                               fontSize: 11,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               Obx(() {
//                 final isFavorite = wishlistController.checkProductStatus(
//                   productDetails.id!,
//                 );
//                 return _IconButtonWidget(
//                   onTap: () {
//                     if (!Get.find<AuthController>().isLoggedIn) {
//                       Get.toNamed(RouteGenerator.login);
//                     } else {
//                       LoadingOverlay.runAsyncTask(context, () async {
//                         if (isFavorite) {
//                           await wishlistController.deleteWishlistItem(
//                             productId: productDetails.id!,
//                           );
//                         } else {
//                           await wishlistController.addWishlistItem(
//                             productId: productDetails.id!,
//                           );
//                         }
//                       });
//                     }
//                   },
//                   icon: Icon(
//                     isFavorite
//                         ? Icons.favorite
//                         : Icons.favorite_border_outlined,
//                     color: isFavorite ? kDeepOrange : kBlackLight,
//                     size: 20,
//                   ),
//                 );
//               }),
//               const SizedBox(width: 8),
//               _IconButtonWidget(
//                 onTap: () {
//                   kShareData(
//                     title: Api.productURL(productDetails.slug ?? ''),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.share,
//                   color: kBlackLight,
//                   size: 20,
//                 ),
//               ),
//             ],
//           ),
//           if (productDetails.stockQty! < 1)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Text(
//                 'Stock Out',
//                 style: context.appTextTheme.bodySmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: kDeepOrange,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 10),
//           KHTMLToWidget(data: productDetails.productShortDescription ?? ''),
//         ],
//       ),
//     );
//   }
// }
//
// class _IconButtonWidget extends StatelessWidget {
//   final VoidCallback onTap;
//   final Widget icon;
//
//   const _IconButtonWidget({
//     super.key,
//     required this.onTap,
//     required this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: kBlackLight.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: icon,
//       ),
//     );
//   }
// }
//
// class _ProductShippingWidget extends StatelessWidget {
//   final ProductDetailsModel productDetails;
//
//   const _ProductShippingWidget({
//     super.key,
//     required this.productDetails,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: kWhite,
//       margin: const EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Shipping: ',
//             style: context.appTextTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.local_shipping,
//                 size: 20,
//                 color: kBlackLight,
//               ),
//               const SizedBox(width: 10),
//               Flexible(
//                 child: Text(
//                   '100% secure payment. 3 Days Return- If goods have problems',
//                   style: context.appTextTheme.bodySmall,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.flash_on,
//                 size: 20,
//                 color: kBlackLight,
//               ),
//               const SizedBox(width: 10),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Ships in',
//                       style: context.appTextTheme.bodySmall,
//                     ),
//                     TextSpan(
//                       text: ' 3-7 days',
//                       style: context.appTextTheme.bodySmall?.copyWith(
//                         color: kDeepOrange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _ProductVariationWidget extends StatelessWidget {
//   const _ProductVariationWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: kWhite,
//       ),
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Product Variation',
//             style: context.appTextTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Size, Color',
//             style: context.appTextTheme.bodySmall,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ProductDetailsWidget extends StatelessWidget {
//   final ProductDetailsModel productDetails;
//
//   const _ProductDetailsWidget({
//     super.key,
//     required this.productDetails,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: kWhite,
//       ),
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Product Details',
//             style: context.appTextTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const KDivider(height: 10),
//           KHTMLToWidget(data: productDetails.details ?? ''),
//         ],
//       ),
//     );
//   }
// }
//
// class _RelatedProductsWidget extends StatelessWidget {
//   final ProductController productController;
//
//   const _RelatedProductsWidget({
//     super.key,
//     required this.productController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => productController.isRelatedProductListLoading.value
//           ? const ProductsLoadingWidget(viewType: ProductsViewType.grid)
//           : productController.relatedProductList.isEmpty
//               ? const SizedBox()
//               : Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     /// Title (Related Products)
//                     const _RelatedProductsTitle(),
//
//                     /// Product List
//                     _RelatedProductList(
//                       productList: productController.relatedProductList,
//                     ),
//                   ],
//                 ),
//     );
//   }
// }
//
// class _RelatedProductsTitle extends StatelessWidget {
//   const _RelatedProductsTitle({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 height: 1.5,
//                 width: 70,
//                 color: const Color(0xFFC4C4C4),
//               ),
//               Positioned(
//                 right: -2,
//                 top: -1.7,
//                 child: Container(
//                   height: 5,
//                   width: 5,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFC4C4C4),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 10),
//           Text(
//             'Related Products',
//             style: context.appTextTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 height: 1.5,
//                 width: 70,
//                 color: const Color(0xFFC4C4C4),
//               ),
//               Positioned(
//                 left: -2,
//                 top: -1.7,
//                 child: Container(
//                   height: 5,
//                   width: 5,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFC4C4C4),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _RelatedProductList extends StatelessWidget {
//   final List<ProductModel> productList;
//
//   const _RelatedProductList({
//     super.key,
//     required this.productList,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ProductsWidget(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       loadedComplete: true,
//       viewType: ProductsViewType.grid,
//       productList: productList,
//     );
//   }
// }
