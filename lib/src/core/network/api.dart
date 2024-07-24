import 'package:amarsolution_multikart/src/core/env/env.dart';

class Api {
  static final String _baseUrl = Env.baseURL;
  static final String siteUrl = Env.siteURL;

  /// auth
  static String get login => '${_baseUrl}login-phone';
  static String get verifyOTP => '${_baseUrl}verify-otp';
  static String get logout => '${_baseUrl}logout';

  /// account
  static String get userInfo => '${_baseUrl}user';
  static String get updateUser => '${_baseUrl}update-profile';

  /// banner
  static String get bannerList => '${_baseUrl}banners';

  /// slider
  static String get sliderList => '${_baseUrl}sliders';

  /// product
  static String get productList => '${_baseUrl}products';
  static String get newArrivalProductList => '${_baseUrl}product-latest';
  static String get flashSalesProductList => '${_baseUrl}product-flash-sale';
  static String get bestSalesProductList => '${_baseUrl}product-bestsale';
  static String get homepageCategoryList => '${_baseUrl}homepage-category';
  static String get searchSummary => '${_baseUrl}search-summary';
  static String productDetails(String slug) => '${_baseUrl}products/$slug';
  static String productURL(String slug) => '${siteUrl}products/$slug';

  /// search-history
  static String get getPopularSearchHistories => '${_baseUrl}popular-search-histories';
  static String get getSearchHistories => '${_baseUrl}search-histories';
  static String deleteSearchHistory({required int id, required dynamic referenceId}) => '${_baseUrl}search-histories-delete/$id?reference_id=$referenceId';
  static String deleteAllSearchHistory({required dynamic referenceId}) => '${_baseUrl}search-histories-all-delete?reference_id=$referenceId';

  /// category
  static String get categoryList => '${_baseUrl}categories';

  /// shop-info
  static String get shopInfo => '${_baseUrl}info/basic';
  static String get paymentMethods => '${_baseUrl}info/payment-method';

  /// checkout
  static String get checkout => '${_baseUrl}checkout';
  static String get guestCheckout => '${_baseUrl}guest-checkout';

  /// coupon
  static String get couponDetails => '${_baseUrl}coupons';

  /// support
  static String get sendMessage => '${_baseUrl}contact-message';

  /// order
  static String get orderList => '${_baseUrl}order';
  static String orderDetails(int id) => '${_baseUrl}order/show/$id';

  /// faq
  static String get faqList => '${_baseUrl}faqs';

  /// wishlist
  static String get getAllWishlist => '${_baseUrl}wishlist';
  static String get addWishlist => '${_baseUrl}wishlist';
  static String deleteWishlist(int productId) => '${_baseUrl}wishlist/destroy/$productId';
}
