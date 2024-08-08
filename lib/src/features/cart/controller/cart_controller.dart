import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
import 'package:amarsolution_multikart/src/features/cart/model/cart_model.dart';

class CartController extends GetxController {
  final _cartList = <CartModel>[].obs;
  final _totalCartAmount = Rx<num>(0.0);

  List<CartModel> get cartList => _cartList;

  int get totalCartItems => _cartList.length;

  num get totalCartAmount => _totalCartAmount.value;

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  void getCartItems() {
    final List<dynamic>? cartJsonList = LocalStorage.getData(
      key: LocalStorageKey.cart,
    );

    _cartList.value = [];
    if (cartJsonList != null) {
      final cartList =
          cartJsonList.map((json) => CartModel.fromJson(json)).toList();
      _cartList.value = cartList;
      _totalCartAmount.value = getTotalAmount;
    }
  }

  num get getTotalAmount {
    try {
      num totalAmount = 0.0;
      for (CartModel cartItem in _cartList) {
        /// Check for null values
        if (cartItem.quantity != null &&
            cartItem.discountSellingPrice != null &&
            cartItem.wholesaleQuantity != null) {
          num amount = cartItem.quantity! * cartItem.discountSellingPrice!;

          /// Apply wholesale pricing if applicable
          if (cartItem.wholesaleQuantity! > 0 &&
              cartItem.quantity! >= cartItem.wholesaleQuantity!) {
            amount = cartItem.quantity! * cartItem.wholesalePrice!;
          }

          totalAmount += amount;
        } else {
          /// If any required property is null, return 0 immediately
          return 0.0;
        }
      }
      return totalAmount;
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      return 0.0;
    }
  }

  /// this method is needed to checkout in checkout page
  num getCartItemPrice(CartModel cartItem) {
    if (cartItem.wholesaleQuantity! > 0 &&
        cartItem.quantity! >= cartItem.wholesaleQuantity!) {
      return cartItem.wholesalePrice ?? 0;
    } else {
      return cartItem.discountSellingPrice ?? 0;
    }
  }

  CartModel? getProduct({
    required int productId,
    required int? variantId,
  }) {
    if (variantId == null) {
      return cartList.firstWhereOrNull(
        (item) => item.productId == productId,
      );
    } else {
      return cartList.firstWhereOrNull(
        (item) => item.productId == productId && item.variant?.id == variantId,
      );
    }
  }

  void addToCart(CartModel cartItem) {
    final List<dynamic>? cartJsonList = LocalStorage.getData(
      key: LocalStorageKey.cart,
    );

    if (cartJsonList != null) {
      final List<CartModel> cartItems =
          cartJsonList.map((json) => CartModel.fromJson(json)).toList();

      /// Check if the item already exists in the cart
      final existingItem = cartItems.firstWhereOrNull((item) =>
          item.productId == cartItem.productId &&
          item.variant?.id == cartItem.variant?.id);
      if (existingItem != null) {
        /// If the item already exists, replace the new quantity
        existingItem.quantity = cartItem.quantity!;
      } else {
        /// If the item doesn't exist, add it to the cart
        cartItems.add(cartItem);
      }
      LocalStorage.saveData(
        key: LocalStorageKey.cart,
        data: cartItems.map((item) => item.toJson()).toList(),
      );
    } else {
      /// If the cart is empty, create a new cart list with the item
      LocalStorage.saveData(
        key: LocalStorageKey.cart,
        data: [cartItem.toJson()],
      );
    }

    getCartItems();
  }

  void removedFromCart({
    required int? productId,
    int? variantId,
  }) {
    if (variantId != null) {
      cartList.removeWhere((item) =>
          item.productId == productId && item.variant?.id == variantId);
    } else {
      cartList.removeWhere((item) => item.productId == productId);
    }

    LocalStorage.saveData(
      key: LocalStorageKey.cart,
      data: cartList.map((item) => item.toJson()).toList(),
    );

    getCartItems();
  }

  void removedAllItems() {
    LocalStorage.removeData(key: LocalStorageKey.cart);
    getCartItems();
  }
}
