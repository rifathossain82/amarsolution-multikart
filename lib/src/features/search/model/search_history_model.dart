class SearchHistoryModel {
  int? id;
  String? searchName;
  DateTime? createdAt;

  SearchHistoryModel({
    this.id,
    this.searchName,
    this.createdAt,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      SearchHistoryModel(
        id: json["id"],
        searchName: json["search_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "search_name": searchName,
        "created_at": createdAt?.toIso8601String(),
      };
}
