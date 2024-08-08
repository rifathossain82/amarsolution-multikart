class CartModel {
  int? productId;
  String? productName;
  String? productImage;
  int? quantity;
  num? stock;
  num? sellingPrice;
  num? discountSellingPrice;
  num? discountValue;
  String? discountType;
  num? wholesalePrice;
  num? wholesaleQuantity;
  CartVariant? variant;

  CartModel({
    this.productId,
    this.productName,
    this.productImage,
    this.quantity,
    this.stock,
    this.sellingPrice,
    this.discountSellingPrice,
    this.discountValue,
    this.discountType,
    this.wholesalePrice,
    this.wholesaleQuantity,
    this.variant,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      quantity: json['quantity'] ?? 0,
      stock: json['stock'] ?? 0,
      sellingPrice: json['sellingPrice'] ?? 0,
      discountSellingPrice: json['discountSellingPrice'] ?? 0,
      discountValue: json['discountValue'] ?? 0,
      discountType: json['discountType'] ?? "",
      wholesalePrice: json['wholesalePrice'] ?? 0,
      wholesaleQuantity: json['wholesaleQuantity'] ?? 0,
      variant: json["variant"] == null ? null : CartVariant.fromJson(json["variant"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'quantity': quantity,
      'stock': stock,
      'sellingPrice': sellingPrice,
      'discountSellingPrice': discountSellingPrice,
      'discountValue': discountValue,
      'discountType': discountType,
      'wholesalePrice': wholesalePrice,
      'wholesaleQuantity': wholesaleQuantity,
      'variant': variant?.toJson(),
    };
  }
}

class CartVariant {
  int? id;
  String? size;
  String? color;

  CartVariant({this.id, this.size, this.color});

  factory CartVariant.fromJson(Map<String, dynamic> json) {
    return CartVariant(
      id: json['id'],
      size: json['size'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'color': color,
    };
  }
}

