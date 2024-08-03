class ProductDetailsModel {
  int? id;
  String? productName;
  String? sku;
  String? slug;
  num? alertQuantity;
  num? oldPrice;
  num? newPrice;
  num? wholesalePrice;
  num? minimumWholesaleQuantity;
  num? discountPercentage;
  String? image;
  List<Photo>? photos;
  dynamic productDescription;
  dynamic specification;
  String? productShortDescription;
  dynamic sizeChart;
  String? details;
  dynamic warranty;
  dynamic videoLink;
  dynamic reviewVideo;
  dynamic metaTag;
  dynamic metaDescription;
  int? status;
  Unit? unit;
  Category? category;
  dynamic attributeCategory;
  dynamic subCategory;
  dynamic childCategory;
  dynamic vatGroup;
  Brand? brand;
  List<Barcode>? barcodes;
  dynamic averageRating;
  num? reviewsCount;
  num? stockQty;
  num? totalSaleQty;
  num? totalRating;
  num? totalQuestionAnswer;
  List<dynamic>? coupons;
  List<dynamic>? includedProducts;
  dynamic flashSale;
  bool? inWishlist;
  DateTime? createdAt;

  ProductDetailsModel({
    this.id,
    this.productName,
    this.sku,
    this.slug,
    this.alertQuantity,
    this.oldPrice,
    this.newPrice,
    this.wholesalePrice,
    this.minimumWholesaleQuantity,
    this.discountPercentage,
    this.image,
    this.photos,
    this.productDescription,
    this.specification,
    this.productShortDescription,
    this.sizeChart,
    this.details,
    this.warranty,
    this.videoLink,
    this.reviewVideo,
    this.metaTag,
    this.metaDescription,
    this.status,
    this.unit,
    this.category,
    this.attributeCategory,
    this.subCategory,
    this.childCategory,
    this.vatGroup,
    this.brand,
    this.barcodes,
    this.averageRating,
    this.reviewsCount,
    this.stockQty,
    this.totalSaleQty,
    this.totalRating,
    this.totalQuestionAnswer,
    this.coupons,
    this.includedProducts,
    this.flashSale,
    this.inWishlist,
    this.createdAt,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    id: json["id"],
    productName: json["product_name"],
    sku: json["sku"],
    slug: json["slug"],
    alertQuantity: json["alert_quantity"],
    oldPrice: json["old_price"],
    newPrice: json["new_price"],
    wholesalePrice: json["wholesale_price"],
    minimumWholesaleQuantity: json["minimum_wholesale_quantity"],
    discountPercentage: json["discount_percentage"],
    image: json["image"],
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    productDescription: json["product_description"],
    specification: json["specification"],
    productShortDescription: json["product_short_description"],
    sizeChart: json["size_chart"],
    details: json["details"],
    warranty: json["warranty"],
    videoLink: json["video_link"],
    reviewVideo: json["review_video"],
    metaTag: json["meta_tag"],
    metaDescription: json["meta_description"],
    status: json["status"],
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    attributeCategory: json["attribute_category"],
    subCategory: json["sub_category"],
    childCategory: json["child_category"],
    vatGroup: json["vat_group"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    barcodes: json["barcodes"] == null ? [] : List<Barcode>.from(json["barcodes"]!.map((x) => Barcode.fromJson(x))),
    averageRating: json["average_rating"],
    reviewsCount: json["reviews_count"],
    stockQty: json["stock_qty"],
    totalSaleQty: json["total_sale_qty"],
    totalRating: json["total_rating"],
    totalQuestionAnswer: json["total_question_answer"],
    coupons: json["coupons"] == null ? [] : List<dynamic>.from(json["coupons"]!.map((x) => x)),
    includedProducts: json["includedProducts"] == null ? [] : List<dynamic>.from(json["includedProducts"]!.map((x) => x)),
    flashSale: json["flashSale"],
    inWishlist: json["in_wishlist"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "sku": sku,
    "slug": slug,
    "alert_quantity": alertQuantity,
    "old_price": oldPrice,
    "new_price": newPrice,
    "wholesale_price": wholesalePrice,
    "minimum_wholesale_quantity": minimumWholesaleQuantity,
    "discount_percentage": discountPercentage,
    "image": image,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "product_description": productDescription,
    "specification": specification,
    "product_short_description": productShortDescription,
    "size_chart": sizeChart,
    "details": details,
    "warranty": warranty,
    "video_link": videoLink,
    "review_video": reviewVideo,
    "meta_tag": metaTag,
    "meta_description": metaDescription,
    "status": status,
    "unit": unit?.toJson(),
    "category": category?.toJson(),
    "attribute_category": attributeCategory,
    "sub_category": subCategory,
    "child_category": childCategory,
    "vat_group": vatGroup,
    "brand": brand?.toJson(),
    "barcodes": barcodes == null ? [] : List<dynamic>.from(barcodes!.map((x) => x.toJson())),
    "average_rating": averageRating,
    "reviews_count": reviewsCount,
    "stock_qty": stockQty,
    "total_sale_qty": totalSaleQty,
    "total_rating": totalRating,
    "total_question_answer": totalQuestionAnswer,
    "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x)),
    "includedProducts": includedProducts == null ? [] : List<dynamic>.from(includedProducts!.map((x) => x)),
    "flashSale": flashSale,
    "in_wishlist": inWishlist,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Barcode {
  int? id;
  String? barcode;
  num? sellingPrice;
  num? wholesalePrice;
  String? discountType;
  num? discountValue;
  num? discountSellingPrice;
  num? stockQty;
  String? size;
  String? color;

  Barcode({
    this.id,
    this.barcode,
    this.sellingPrice,
    this.wholesalePrice,
    this.discountType,
    this.discountValue,
    this.discountSellingPrice,
    this.stockQty,
    this.size,
    this.color,
  });

  factory Barcode.fromJson(Map<String, dynamic> json) => Barcode(
    id: json["id"],
    barcode: json["barcode"],
    sellingPrice: json["selling_price"],
    wholesalePrice: json["wholesale_price"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"] ?? 0,
    discountSellingPrice: json["discount_selling_price"],
    stockQty: json["stock_qty"],
    size: json["size"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "barcode": barcode,
    "selling_price": sellingPrice,
    "wholesale_price": wholesalePrice,
    "discount_type": discountType,
    "discount_value": discountValue,
    "discount_selling_price": discountSellingPrice,
    "stock_qty": stockQty,
    "size": size,
    "color": color,
  };
}

class Brand {
  int? id;
  String? brandName;
  dynamic logo;

  Brand({
    this.id,
    this.brandName,
    this.logo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    brandName: json["brand_name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "logo": logo,
  };
}

class Category {
  int? id;
  int? parentId;
  String? slug;
  String? categoryName;
  String? icon;
  dynamic image;
  String? parentName;
  String? parentSlug;
  List<Category>? childCategories;

  Category({
    this.id,
    this.parentId,
    this.slug,
    this.categoryName,
    this.icon,
    this.image,
    this.parentName,
    this.parentSlug,
    this.childCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    parentId: json["parent_id"],
    slug: json["slug"],
    categoryName: json["category_name"],
    icon: json["icon"],
    image: json["image"],
    parentName: json["parent_name"],
    parentSlug: json["parent_slug"],
    childCategories: json["child_categories"] == null ? [] : List<Category>.from(json["child_categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "slug": slug,
    "category_name": categoryName,
    "icon": icon,
    "image": image,
    "parent_name": parentName,
    "parent_slug": parentSlug,
    "child_categories": childCategories == null ? [] : List<dynamic>.from(childCategories!.map((x) => x.toJson())),
  };
}

class Photo {
  String? image;
  dynamic videoLink;
  String? colorName;
  dynamic colorCode;

  Photo({
    this.image,
    this.videoLink,
    this.colorName,
    this.colorCode,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    image: json["image"],
    videoLink: json["video_link"],
    colorName: json["color_name"],
    colorCode: json["color_code"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "video_link": videoLink,
    "color_name": colorName,
    "color_code": colorCode,
  };
}

class Unit {
  int? id;
  String? name;

  Unit({
    this.id,
    this.name,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
