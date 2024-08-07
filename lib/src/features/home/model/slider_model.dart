class SliderModel {
  int? id;
  String? title;
  String? title2;
  String? text;
  String? url;
  String? image;
  int? sortIndex;
  int? status;

  SliderModel({
    this.id,
    this.title,
    this.title2,
    this.text,
    this.url,
    this.image,
    this.sortIndex,
    this.status,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    title2 = json['title_2'];
    text = json['text'];
    url = json['url'];
    image = json['image'];
    sortIndex = json['sort_index'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['title_2'] = title2;
    data['text'] = text;
    data['url'] = url;
    data['image'] = image;
    data['sort_index'] = sortIndex;
    data['status'] = status;
    return data;
  }
}
