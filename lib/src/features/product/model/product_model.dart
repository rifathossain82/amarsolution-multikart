import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';

class ProductModel {
  int? id;
  bool? inWishlist;
  String? productName;
  String? barcode;
  String? sku;
  String? slug;
  num? alertQuantity;
  num? oldPrice;
  num? newPrice;
  num? wholesalePrice;
  num? minimumWholesaleQuantity;
  num? discountPercentage;
  String? image;
  int? status;
  Unit? unit;
  CategoryModel? category;
  Brand? brand;
  List<ProductVariants>? productVariants;
  num? averateRating;
  dynamic reviewsCount;
  num? stockQty;
  num? totalSaleQty;
  num? totalRating;
  num? toptalQuestionAnswer;
  String? createdAt;

  ProductModel({
    this.id,
    this.inWishlist,
    this.productName,
    this.barcode,
    this.sku,
    this.slug,
    this.alertQuantity,
    this.oldPrice,
    this.newPrice,
    this.wholesalePrice,
    this.minimumWholesaleQuantity,
    this.discountPercentage,
    this.image,
    this.status,
    this.unit,
    this.category,
    this.brand,
    this.productVariants,
    this.averateRating,
    this.reviewsCount,
    this.stockQty,
    this.totalSaleQty,
    this.totalRating,
    this.toptalQuestionAnswer,
    this.createdAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inWishlist = json['in_wishlist'] ?? false;
    productName = json['product_name'];
    barcode = json['barcode'];
    sku = json['sku'];
    slug = json['slug'];
    alertQuantity = json['alert_quantity'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    wholesalePrice = json['wholesale_price'];
    minimumWholesaleQuantity = json['minimum_wholesale_quantity'];
    discountPercentage = json['discount_percentage'];
    image = json['image'];
    status = json['status'];
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    if (json['productVariants'] != null) {
      productVariants = <ProductVariants>[];
      json['productVariants'].forEach((v) {
        productVariants!.add(ProductVariants.fromJson(v));
      });
    }
    averateRating = json['averate_rating'];
    reviewsCount = json['reviews_count'];
    stockQty = json['stock_qty'] ?? 0;
    totalSaleQty = json['total_sale_qty'];
    totalRating = json['total_rating'];
    toptalQuestionAnswer = json['toptal_question_answer'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['in_wishlist'] = inWishlist;
    data['product_name'] = productName;
    data['barcode'] = barcode;
    data['sku'] = sku;
    data['slug'] = slug;
    data['alert_quantity'] = alertQuantity;
    data['old_price'] = oldPrice;
    data['new_price'] = newPrice;
    data['wholesale_price'] = wholesalePrice;
    data['minimum_wholesale_quantity'] = minimumWholesaleQuantity;
    data['discount_percentage'] = discountPercentage;
    data['image'] = image;
    data['status'] = status;
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (productVariants != null) {
      data['productVariants'] =
          productVariants!.map((v) => v.toJson()).toList();
    }
    data['averate_rating'] = averateRating;
    data['reviews_count'] = reviewsCount;
    data['stock_qty'] = stockQty;
    data['total_sale_qty'] = totalSaleQty;
    data['total_rating'] = totalRating;
    data['toptal_question_answer'] = toptalQuestionAnswer;
    data['created_at'] = createdAt;
    return data;
  }
}

class Unit {
  int? id;
  int? bussinessId;
  String? actualName;
  String? shortName;
  int? isDecimal;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  List<UnitTranslations>? unitTranslations;

  Unit({
    this.id,
    this.bussinessId,
    this.actualName,
    this.shortName,
    this.isDecimal,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.unitTranslations,
  });

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bussinessId = json['bussiness_id'];
    actualName = json['actual_name'];
    shortName = json['short_name'];
    isDecimal = json['is_decimal'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['unit_translations'] != null) {
      unitTranslations = <UnitTranslations>[];
      json['unit_translations'].forEach((v) {
        unitTranslations!.add(UnitTranslations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bussiness_id'] = bussinessId;
    data['actual_name'] = actualName;
    data['short_name'] = shortName;
    data['is_decimal'] = isDecimal;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (unitTranslations != null) {
      data['unit_translations'] =
          unitTranslations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnitTranslations {
  int? id;
  int? unitId;
  String? lang;
  String? actualName;
  String? shortName;
  String? createdAt;
  String? updatedAt;

  UnitTranslations({
    this.id,
    this.unitId,
    this.lang,
    this.actualName,
    this.shortName,
    this.createdAt,
    this.updatedAt,
  });

  UnitTranslations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unit_id'];
    lang = json['lang'];
    actualName = json['actual_name'];
    shortName = json['short_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_id'] = unitId;
    data['lang'] = lang;
    data['actual_name'] = actualName;
    data['short_name'] = shortName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Brand {
  int? id;
  int? bussinessId;
  String? brandName;
  int? createdBy;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? logo;
  String? description;
  String? url;
  int? sortIndex;
  List<BrandTranslations>? brandTranslations;

  Brand({
    this.id,
    this.bussinessId,
    this.brandName,
    this.createdBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.logo,
    this.description,
    this.url,
    this.sortIndex,
    this.brandTranslations,
  });

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bussinessId = json['bussiness_id'];
    brandName = json['brand_name'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logo = json['logo'];
    description = json['description'];
    url = json['url'];
    sortIndex = json['sort_index'];
    if (json['brand_translations'] != null) {
      brandTranslations = <BrandTranslations>[];
      json['brand_translations'].forEach((v) {
        brandTranslations!.add(BrandTranslations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bussiness_id'] = bussinessId;
    data['brand_name'] = brandName;
    data['created_by'] = createdBy;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['logo'] = logo;
    data['description'] = description;
    data['url'] = url;
    data['sort_index'] = sortIndex;
    if (brandTranslations != null) {
      data['brand_translations'] =
          brandTranslations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandTranslations {
  int? id;
  int? brandId;
  String? lang;
  String? brandName;
  String? description;
  String? url;
  String? createdAt;
  String? updatedAt;

  BrandTranslations({
    this.id,
    this.brandId,
    this.lang,
    this.brandName,
    this.description,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  BrandTranslations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    lang = json['lang'];
    brandName = json['brand_name'];
    description = json['description'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_id'] = brandId;
    data['lang'] = lang;
    data['brand_name'] = brandName;
    data['description'] = description;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProductVariants {
  int? id;
  int? bussinessId;
  int? productId;
  String? size;
  String? color;
  int? purchaseQuantity;
  int? soldQuantity;
  int? returnQuantity;
  String? createdAt;
  String? updatedAt;
  int? transferInQuantity;
  int? transferOutQuantity;
  int? phyQty;
  int? adjustmentQty;
  int? exchangeQty;
  int? openingQuantity;
  int? availableQuantity;

  ProductVariants({
    this.id,
    this.bussinessId,
    this.productId,
    this.size,
    this.color,
    this.purchaseQuantity,
    this.soldQuantity,
    this.returnQuantity,
    this.createdAt,
    this.updatedAt,
    this.transferInQuantity,
    this.transferOutQuantity,
    this.phyQty,
    this.adjustmentQty,
    this.exchangeQty,
    this.openingQuantity,
    this.availableQuantity,
  });

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bussinessId = json['bussiness_id'];
    productId = json['product_id'];
    size = json['size'];
    color = json['color'];
    purchaseQuantity = json['purchase_quantity'];
    soldQuantity = json['sold_quantity'];
    returnQuantity = json['return_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transferInQuantity = json['transfer_in_quantity'];
    transferOutQuantity = json['transfer_out_quantity'];
    phyQty = json['phy_qty'];
    adjustmentQty = json['adjustment_qty'];
    exchangeQty = json['exchange_qty'];
    openingQuantity = json['opening_quantity'];
    availableQuantity = json['available_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bussiness_id'] = bussinessId;
    data['product_id'] = productId;
    data['size'] = size;
    data['color'] = color;
    data['purchase_quantity'] = purchaseQuantity;
    data['sold_quantity'] = soldQuantity;
    data['return_quantity'] = returnQuantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['transfer_in_quantity'] = transferInQuantity;
    data['transfer_out_quantity'] = transferOutQuantity;
    data['phy_qty'] = phyQty;
    data['adjustment_qty'] = adjustmentQty;
    data['exchange_qty'] = exchangeQty;
    data['opening_quantity'] = openingQuantity;
    data['available_quantity'] = availableQuantity;
    return data;
  }
}
