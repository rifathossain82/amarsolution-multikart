class BannerModel {
  int? id;
  String? title;
  String? title2;
  String? url;
  String? image;
  String? position;
  int? sortIndex;

  BannerModel({
    this.id,
    this.title,
    this.title2,
    this.url,
    this.image,
    this.position,
    this.sortIndex,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        title: json["title"],
        title2: json["title_2"],
        url: json["url"],
        image: json["image"],
        position: json["position"],
        sortIndex: json["sort_index"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "title_2": title2,
        "url": url,
        "image": image,
        "position": position,
        "sort_index": sortIndex,
      };
}
