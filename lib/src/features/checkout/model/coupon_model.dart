class CouponModel {
  int? id;
  String? code;
  String? couponType;
  String? discountType;
  num? discountAmount;
  num? maxDiscount;
  DateTime? startDate;
  DateTime? endDate;
  num? maxUseLimit;
  String? eligibleFor;
  String? minimumOrder;

  CouponModel({
    this.id,
    this.code,
    this.couponType,
    this.discountType,
    this.discountAmount,
    this.maxDiscount,
    this.startDate,
    this.endDate,
    this.maxUseLimit,
    this.eligibleFor,
    this.minimumOrder,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    id: json["id"],
    code: json["code"],
    couponType: json["coupon_type"],
    discountType: json["discount_type"],
    discountAmount: json["discount_amount"],
    maxDiscount: json["max_discount"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    maxUseLimit: json["max_use_limit"],
    eligibleFor: json["eligible_for"],
    minimumOrder: json["minimum_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "coupon_type": couponType,
    "discount_type": discountType,
    "discount_amount": discountAmount,
    "max_discount": maxDiscount,
    "start_date": "$startDate",
    "end_date": "$endDate",
    "max_use_limit": maxUseLimit,
    "eligible_for": eligibleFor,
    "minimum_order": minimumOrder,
  };
}