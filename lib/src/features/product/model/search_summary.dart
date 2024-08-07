class SearchSummaryModel {
  List<SummaryBrandModel>? brands;
  num? minPrice;
  num? maxPrice;
  List<SummarySizeModel>? sizes;
  List<SummaryColorModel>? colors;

  SearchSummaryModel({
    this.brands,
    this.minPrice,
    this.maxPrice,
    this.sizes,
    this.colors,
  });

  SearchSummaryModel.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <SummaryBrandModel>[];
      json['brands'].forEach((v) {
        brands!.add(SummaryBrandModel.fromJson(v));
      });
    }
    minPrice = json['min_price'] ?? 0;
    maxPrice = json['max_price'] ?? 0;
    if (json['sizes'] != null) {
      sizes = <SummarySizeModel>[];
      json['sizes'].forEach((v) {
        sizes!.add(SummarySizeModel.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <SummaryColorModel>[];
      json['colors'].forEach((v) {
        colors!.add(SummaryColorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SummaryBrandModel {
  int? id;
  int? bussinessId;
  String? brandName;
  String? brandImage;
  String? description;
  int? status;

  SummaryBrandModel({
    this.id,
    this.bussinessId,
    this.brandName,
    this.brandImage,
    this.description,
    this.status,
  });

  SummaryBrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bussinessId = json['bussiness_id'];
    brandName = json['brand_name'];
    brandImage = json['brand_image'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bussiness_id'] = bussinessId;
    data['brand_name'] = brandName;
    data['brand_image'] = brandImage;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}

class SummarySizeModel {
  int? id;
  String? name;

  SummarySizeModel({
    this.id,
    this.name,
  });

  SummarySizeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class SummaryColorModel {
  int? id;
  String? name;
  String? code;

  SummaryColorModel({
    this.id,
    this.name,
    this.code,
  });

  SummaryColorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
