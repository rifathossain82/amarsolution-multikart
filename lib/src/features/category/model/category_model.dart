class CategoryModel {
  int? id;
  dynamic parentId;
  String? slug;
  String? categoryName;
  String? description;
  String? icon;
  String? image;
  dynamic parentName;
  dynamic parentSlug;
  List<CategoryModel>? childCategories;

  CategoryModel({
    this.id,
    this.parentId,
    this.slug,
    this.categoryName,
    this.description,
    this.icon,
    this.image,
    this.parentName,
    this.parentSlug,
    this.childCategories,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    categoryName = json['category_name'];
    description = json['description'];
    icon = json['icon'];
    image = json['image'];
    parentName = json['parent_name'];
    parentSlug = json['parent_slug'];
    if (json['child_categories'] != null) {
      childCategories = <CategoryModel>[];
      json['child_categories'].forEach((v) {
        childCategories!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['icon'] = icon;
    data['image'] = image;
    data['parent_name'] = parentName;
    data['parent_slug'] = parentSlug;
    if (childCategories != null) {
      data['child_categories'] =
          childCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}