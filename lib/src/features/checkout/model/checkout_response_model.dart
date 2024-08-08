class CheckoutResponseModel {
  Sale? sale;
  List<SaleProduct>? saleProducts;
  List<dynamic>? saleReturn;
  List<dynamic>? customerPayment;
  List<dynamic>? duePaymentDetails;
  dynamic deliveryCompany;
  List<dynamic>? installments;
  dynamic duePayment;
  dynamic exchange;
  List<dynamic>? exchangeProducts;
  String? message;

  CheckoutResponseModel({
    this.sale,
    this.saleProducts,
    this.saleReturn,
    this.customerPayment,
    this.duePaymentDetails,
    this.deliveryCompany,
    this.installments,
    this.duePayment,
    this.exchange,
    this.exchangeProducts,
    this.message,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) => CheckoutResponseModel(
    sale: json["sale"] == null ? null : Sale.fromJson(json["sale"]),
    saleProducts: json["saleProducts"] == null ? [] : List<SaleProduct>.from(json["saleProducts"]!.map((x) => SaleProduct.fromJson(x))),
    saleReturn: json["saleReturn"] == null ? [] : List<dynamic>.from(json["saleReturn"]!.map((x) => x)),
    customerPayment: json["customerPayment"] == null ? [] : List<dynamic>.from(json["customerPayment"]!.map((x) => x)),
    duePaymentDetails: json["duePaymentDetails"] == null ? [] : List<dynamic>.from(json["duePaymentDetails"]!.map((x) => x)),
    deliveryCompany: json["deliveryCompany"],
    installments: json["installments"] == null ? [] : List<dynamic>.from(json["installments"]!.map((x) => x)),
    duePayment: json["duePayment"],
    exchange: json["exchange"],
    exchangeProducts: json["exchangeProducts"] == null ? [] : List<dynamic>.from(json["exchangeProducts"]!.map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "sale": sale?.toJson(),
    "saleProducts": saleProducts == null ? [] : List<dynamic>.from(saleProducts!.map((x) => x.toJson())),
    "saleReturn": saleReturn == null ? [] : List<dynamic>.from(saleReturn!.map((x) => x)),
    "customerPayment": customerPayment == null ? [] : List<dynamic>.from(customerPayment!.map((x) => x)),
    "duePaymentDetails": duePaymentDetails == null ? [] : List<dynamic>.from(duePaymentDetails!.map((x) => x)),
    "deliveryCompany": deliveryCompany,
    "installments": installments == null ? [] : List<dynamic>.from(installments!.map((x) => x)),
    "duePayment": duePayment,
    "exchange": exchange,
    "exchangeProducts": exchangeProducts == null ? [] : List<dynamic>.from(exchangeProducts!.map((x) => x)),
    "message": message,
  };
}

class Sale {
  int? id;
  String? invoiceNo;
  int? userId;
  DateTime? saleDate;
  String? status;
  num? totalAmount;
  num? discountAmount;
  num? paidAmount;
  num? dueAmount;
  num? subTotal;
  dynamic deleveryDate;
  Shipping? shipping;
  Customer? customer;
  Customer? user;
  num? totalProduct;
  String? paymentType;

  Sale({
    this.id,
    this.invoiceNo,
    this.userId,
    this.saleDate,
    this.status,
    this.totalAmount,
    this.discountAmount,
    this.paidAmount,
    this.dueAmount,
    this.subTotal,
    this.deleveryDate,
    this.shipping,
    this.customer,
    this.user,
    this.totalProduct,
    this.paymentType,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    id: json["id"],
    invoiceNo: json["invoice_no"],
    userId: json["user_id"],
    saleDate: json["sale_date"] == null ? null : DateTime.parse(json["sale_date"]),
    status: json["status"],
    totalAmount: json["total_amount"],
    discountAmount: json["discount_amount"],
    paidAmount: json["paid_amount"],
    dueAmount: json["due_amount"],
    subTotal: json["sub_total"],
    deleveryDate: json["delevery_date"],
    shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    user: json["user"] == null ? null : Customer.fromJson(json["user"]),
    totalProduct: json["total_product"],
    paymentType: json["payment_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_no": invoiceNo,
    "user_id": userId,
    "sale_date": "${saleDate!.year.toString().padLeft(4, '0')}-${saleDate!.month.toString().padLeft(2, '0')}-${saleDate!.day.toString().padLeft(2, '0')}",
    "status": status,
    "total_amount": totalAmount,
    "discount_amount": discountAmount,
    "paid_amount": paidAmount,
    "due_amount": dueAmount,
    "sub_total": subTotal,
    "delevery_date": deleveryDate,
    "shipping": shipping?.toJson(),
    "customer": customer?.toJson(),
    "user": user?.toJson(),
    "total_product": totalProduct,
    "payment_type": paymentType,
  };
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? phone;

  Customer({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "phone": phone,
  };
}

class Shipping {
  int? id;
  int? saleId;
  int? contactId;
  String? name;
  String? phone;
  String? address;
  String? altName;
  String? altPhone;
  String? altAddress;
  String? deliveryType;
  num? deliveryCharge;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deliveryCompanyId;
  dynamic cityId;

  Shipping({
    this.id,
    this.saleId,
    this.contactId,
    this.name,
    this.phone,
    this.address,
    this.altName,
    this.altPhone,
    this.altAddress,
    this.deliveryType,
    this.deliveryCharge,
    this.createdAt,
    this.updatedAt,
    this.deliveryCompanyId,
    this.cityId,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    id: json["id"],
    saleId: json["sale_id"],
    contactId: json["contact_id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    altName: json["alt_name"],
    altPhone: json["alt_phone"],
    altAddress: json["alt_address"],
    deliveryType: json["delivery_type"],
    deliveryCharge: json["delivery_charge"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deliveryCompanyId: json["delivery_company_id"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_id": saleId,
    "contact_id": contactId,
    "name": name,
    "phone": phone,
    "address": address,
    "alt_name": altName,
    "alt_phone": altPhone,
    "alt_address": altAddress,
    "delivery_type": deliveryType,
    "delivery_charge": deliveryCharge,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "delivery_company_id": deliveryCompanyId,
    "city_id": cityId,
  };
}

class SaleProduct {
  num? qty;
  num? returnQty;
  num? finalQty;
  num? price;
  num? totalPrice;
  DateTime? createdAt;
  ProductVariantClass? productVariant;
  Product? product;

  SaleProduct({
    this.qty,
    this.returnQty,
    this.finalQty,
    this.price,
    this.totalPrice,
    this.createdAt,
    this.productVariant,
    this.product,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) => SaleProduct(
    qty: json["qty"],
    returnQty: json["return_qty"],
    finalQty: json["final_qty"],
    price: json["price"],
    totalPrice: json["total_price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    productVariant: json["product_variant"] == null ? null : ProductVariantClass.fromJson(json["product_variant"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "qty": qty,
    "return_qty": returnQty,
    "final_qty": finalQty,
    "price": price,
    "total_price": totalPrice,
    "created_at": createdAt?.toIso8601String(),
    "product_variant": productVariant?.toJson(),
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  bool? inWishlist;
  String? productName;
  String? barcode;
  dynamic sku;
  String? slug;
  dynamic alertQuantity;
  num? oldPrice;
  num? newPrice;
  num? wholesalePrice;
  num? minimumWholesaleQuantity;
  num? discountPercentage;
  String? image;
  int? status;
  Unit? unit;
  Category? category;
  dynamic brand;
  List<ProductVariant>? productVariants;
  dynamic averateRating;
  dynamic reviewsCount;
  num? stockQty;
  num? totalSaleQty;
  num? totalRating;
  num? toptalQuestionAnswer;
  DateTime? createdAt;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    inWishlist: json["in_wishlist"],
    productName: json["product_name"],
    barcode: json["barcode"],
    sku: json["sku"],
    slug: json["slug"],
    alertQuantity: json["alert_quantity"],
    oldPrice: json["old_price"],
    newPrice: json["new_price"],
    wholesalePrice: json["wholesale_price"],
    minimumWholesaleQuantity: json["minimum_wholesale_quantity"],
    discountPercentage: json["discount_percentage"],
    image: json["image"],
    status: json["status"],
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"],
    productVariants: json["productVariants"] == null ? [] : List<ProductVariant>.from(json["productVariants"]!.map((x) => ProductVariant.fromJson(x))),
    averateRating: json["averate_rating"],
    reviewsCount: json["reviews_count"],
    stockQty: json["stock_qty"],
    totalSaleQty: json["total_sale_qty"],
    totalRating: json["total_rating"],
    toptalQuestionAnswer: json["toptal_question_answer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "in_wishlist": inWishlist,
    "product_name": productName,
    "barcode": barcode,
    "sku": sku,
    "slug": slug,
    "alert_quantity": alertQuantity,
    "old_price": oldPrice,
    "new_price": newPrice,
    "wholesale_price": wholesalePrice,
    "minimum_wholesale_quantity": minimumWholesaleQuantity,
    "discount_percentage": discountPercentage,
    "image": image,
    "status": status,
    "unit": unit?.toJson(),
    "category": category?.toJson(),
    "brand": brand,
    "productVariants": productVariants == null ? [] : List<dynamic>.from(productVariants!.map((x) => x.toJson())),
    "averate_rating": averateRating,
    "reviews_count": reviewsCount,
    "stock_qty": stockQty,
    "total_sale_qty": totalSaleQty,
    "total_rating": totalRating,
    "toptal_question_answer": toptalQuestionAnswer,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Category {
  int? id;
  String? slug;
  String? categoryName;
  dynamic icon;

  Category({
    this.id,
    this.slug,
    this.categoryName,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    slug: json["slug"],
    categoryName: json["category_name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "category_name": categoryName,
    "icon": icon,
  };
}

class ProductVariant {
  int? id;
  int? productId;
  String? size;
  String? color;
  num? stockQuantity;

  ProductVariant({
    this.id,
    this.productId,
    this.size,
    this.color,
    this.stockQuantity,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    id: json["id"],
    productId: json["product_id"],
    size: json["size"],
    color: json["color"],
    stockQuantity: json["stock_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "size": size,
    "color": color,
    "stock_quantity": stockQuantity,
  };
}

class Unit {
  int? id;
  String? actualName;
  int? isDecimal;

  Unit({
    this.id,
    this.actualName,
    this.isDecimal,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    actualName: json["actual_name"],
    isDecimal: json["is_decimal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "actual_name": actualName,
    "is_decimal": isDecimal,
  };
}

class ProductVariantClass {
  int? id;
  String? color;
  String? size;

  ProductVariantClass({
    this.id,
    this.color,
    this.size,
  });

  factory ProductVariantClass.fromJson(Map<String, dynamic> json) => ProductVariantClass(
    id: json["id"],
    color: json["color"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "size": size,
  };
}
