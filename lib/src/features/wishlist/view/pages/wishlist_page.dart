import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/theme/app_theme.dart';
import 'package:amarsolution_multikart/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:amarsolution_multikart/src/features/wishlist/view/widgets/empty_wishlist_widget.dart';
import 'package:amarsolution_multikart/src/features/wishlist/view/widgets/wishlist_item_widget.dart';
import 'package:amarsolution_multikart/src/features/wishlist/view/widgets/wishlist_page_loading_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final wishlistController = Get.find<WishlistController>();

  @override
  void initState() {
    wishlistController.getWishlistItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        // systemOverlayStyle: AppTheme.lightSystemOverlayStyle(),
      ),
      body: Obx(() {
        return wishlistController.isWishlistItemsLoading.value
            ? const WishlistPageLoadingWidget()
            : wishlistController.wishlistItems.isEmpty
                ? const EmptyWishlistWidget()
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: wishlistController.wishlistItems.length,
                    itemBuilder: (context, index) => WishlistItemWidget(
                      product: wishlistController.wishlistItems[index],
                      wishlistController: wishlistController,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  );
      }),
    );
  }
}
