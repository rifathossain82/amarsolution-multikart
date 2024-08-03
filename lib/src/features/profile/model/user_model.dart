class UserModel {
  int? id;
  dynamic firstName;
  dynamic lastName;
  String? name;
  dynamic email;
  String? phone;
  dynamic altPhoneNo;
  String? gender;
  dynamic city;
  dynamic zip;
  String? country;
  String? countryCode;
  dynamic address;
  dynamic image;
  dynamic birthDate;
  int? status;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.email,
    this.phone,
    this.altPhoneNo,
    this.gender,
    this.city,
    this.zip,
    this.country,
    this.countryCode,
    this.address,
    this.image,
    this.birthDate,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    altPhoneNo: json["alt_phone_no"],
    gender: json["gender"],
    city: json["city"],
    zip: json["zip"],
    country: json["country"],
    countryCode: json["country_code"],
    address: json["address"],
    image: json["image"],
    birthDate: json["birth_date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "email": email,
    "phone": phone,
    "alt_phone_no": altPhoneNo,
    "gender": gender,
    "city": city,
    "zip": zip,
    "country": country,
    "country_code": countryCode,
    "address": address,
    "image": image,
    "birth_date": birthDate,
    "status": status,
  };
}
