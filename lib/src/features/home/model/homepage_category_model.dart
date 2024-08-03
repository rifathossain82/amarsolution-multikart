import 'package:amarsolution_multikart/src/features/product/model/product_model.dart';

class HomepageCategoryModel {
  Category? category;
  List<ProductModel>? products;

  HomepageCategoryModel({
    this.category,
    this.products,
  });

  factory HomepageCategoryModel.fromJson(Map<String, dynamic> json) =>
      HomepageCategoryModel(
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"]!.map((x) => ProductModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "products": products == null
            ? []
            : List<ProductModel>.from(products!.map((x) => x.toJson())),
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
