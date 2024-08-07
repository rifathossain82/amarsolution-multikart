class PaymentMethodModel {
  CashOnDelivery? cashOnDelivery;
  Ssl? ssl;

  PaymentMethodModel({
    this.cashOnDelivery,
    this.ssl,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        cashOnDelivery: json["cash_on_delivery"] == null
            ? null
            : CashOnDelivery.fromJson(json["cash_on_delivery"]),
        ssl: json["ssl"] == null ? null : Ssl.fromJson(json["ssl"]),
      );

  Map<String, dynamic> toJson() => {
        "cash_on_delivery": cashOnDelivery?.toJson(),
        "ssl": ssl?.toJson(),
      };
}

class CashOnDelivery {
  int? status;
  String? key;
  String? icon;
  String? title;

  CashOnDelivery({
    this.status,
    this.key,
    this.icon,
    this.title,
  });

  factory CashOnDelivery.fromJson(Map<String, dynamic> json) => CashOnDelivery(
        status: json["status"],
        key: json["key"],
        icon: json["icon"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "key": key,
        "icon": icon,
        "title": title,
      };
}

class Ssl {
  int? status;
  String? key;
  String? icon;
  String? title;
  dynamic sslStoreId;
  dynamic sslStorePassword;

  Ssl({
    this.status,
    this.key,
    this.icon,
    this.title,
    this.sslStoreId,
    this.sslStorePassword,
  });

  factory Ssl.fromJson(Map<String, dynamic> json) => Ssl(
        status: json["status"],
        key: json["key"],
        icon: json["icon"],
        title: json["title"],
        sslStoreId: json["ssl_store_id"],
        sslStorePassword: json["ssl_store_password"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "key": key,
        "icon": icon,
        "title": title,
        "ssl_store_id": sslStoreId,
        "ssl_store_password": sslStorePassword,
      };
}
